
  nomainwin

  WindowWidth = 200
  WindowHeight = 270

  statictext #ram.used, "", 20, 10, 200, 25
  statictext #ram.total, "", 20, 40, 200, 25
  statictext #ram.free, "", 20, 70, 200, 25
  statictext #ram.totpage, "", 20, 100, 200, 25
  statictext #ram.frpage, "", 20, 130, 200, 25
  statictext #ram.totvirt, "", 20, 160, 200, 25
  statictext #ram.frvirt, "", 20, 190, 200, 25

  menu #ram, "Help", _
             "Help Topics", [hlp]

  menu #ram, "About", _
             "About RAMUsage", [about]

  open "RAMUsage" for window_nf as #ram

  #ram, "trapclose [quit]"

  #ram.used, "!font arial 5 15"
  #ram.total, "!font arial 5 15"
  #ram.free, "!font arial 5 15"
  #ram.totpage, "!font arial 5 15"
  #ram.frpage, "!font arial 5 15"
  #ram.totvirt, "!font arial 5 15"
  #ram.frvirt, "!font arial 5 15"

  struct memorystatus, _
    length as ulong, _
    UsedRam as ulong, _
    TotalRam as ulong, _
    FreeRam as ulong, _
    TotalPage as ulong, _
    FreePage as ulong, _
    TotalVir as ulong, _
    FreeVir as ulong
    memorystatus.length.struct = 32

  h = hwnd(#ram)

'----------------------------------------------------------------------------------------------------------------------------------------------

  [main]

  calldll #kernel32, "GlobalMemoryStatus", _
    memorystatus as struct, _
    result as void

  #ram.used, "RAM Used: " ; int((memorystatus.TotalRam.struct - memorystatus.FreeRam.struct) / 1024000) ; " MB"
  #ram.total, "RAM Total: " ; int(memorystatus.TotalRam.struct / 1024000) ; " MB"
  #ram.free, "RAM Free: " ; int(memorystatus.FreeRam.struct / 1024000) ; " MB"
  #ram.totpage, "RAM Total Paged: " ; int(memorystatus.TotalPage.struct / 1024000) ; " MB"
  #ram.frpage, "RAM Free Paged: " ; int(memorystatus.FreePage.struct / 1024000) ; " MB"
  #ram.totvirt, "RAM Total Virtual: " ; int(memorystatus.TotalVir.struct / 1024000) ; " MB"
  #ram.frvirt, "RAM Free Virtual: " ; int(memorystatus.FreeVir.struct / 1024000) ; " MB"

  timer 250, [main]
  wait

'----------------------------------------------------------------------------------------------------------------------------------------------

  [quit]

  close #ram
  end

'----------------------------------------------------------------------------------------------------------------------------------------------

  [hlp]

  run "Notepad RAMUsage.txt"

  wait

'----------------------------------------------------------------------------------------------------------------------------------------------

  [about]

  icon$ = "RAMUsage.ico"

  calldll #shell32, "ExtractIconA", _
      0 as long, _
      icon$ as ptr, _
      0 as long, _
      hIcon as ulong

  szApp$ = "About RAMUsage ver 1.0 # Built in Liberty Basic ver 4.03"
  cr$ = chr$(13)
  szOtherStuff$ = cr$ + "Created by Alexander Kampolis" + cr$

  calldll #shell32, "ShellAboutA", _
      h as ulong, _
      szApp$ as ptr, _
      szOtherStuff$ as ptr, _
      hIcon as ulong, _
      ret as long

  wait


