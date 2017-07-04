; 选择压缩方式
;SetCompressor /SOLID LZMA
SetCompressor lzma

;--------------------------------
; 引入的头文件
!include "nsDialogs.nsh"
!include "FileFunc.nsh"
!include  MUI.nsh
!include  LogicLib.nsh
!include  WinMessages.nsh
!include "MUI2.nsh"
!include "WordFunc.nsh"
!include "Library.nsh"
!include "basehelp.nsh"

;--------------------------------
; 引入的dll
ReserveFile "${NSISDIR}\Plugins\system.dll"
ReserveFile "${NSISDIR}\Plugins\nsDialogs.dll"
ReserveFile "${NSISDIR}\Plugins\nsExec.dll"
ReserveFile "${NSISDIR}\Plugins\InstallOptions.dll"
ReserveFile "${NSISDIR}\Plugins\nsTBCIASkinEngine.dll" ;调用我们的皮肤插件

; --------------------------------
; This macro:
; 1. Creates a temporary .nsi file
; 2. Compiles the temporary .nsi to a temporary executable
; 3. Runs the temporary .exe
; 4. Deletes the two files (.nsi and .exe)
; 5. Returns an array containing the version info of the specified executable.
;
; Example:
; !insertmacro GetVersionLocal "$%windir%\Explorer.exe" MyVer_
; VIProductVersion "${MyVer_1}.${MyVer_2}.${MyVer_3}.${MyVer_4}"
; VIAddVersionKey "FileVersion" "${MyVer_1}.${MyVer_2}.${MyVer_3}.${MyVer_4}"
; --------------------------------
!macro GetVersionLocal file basedef
!verbose push
!verbose 1
!tempfile _GetVersionLocal_nsi
!tempfile _GetVersionLocal_exe
!appendfile "${_GetVersionLocal_nsi}" 'Outfile "${_GetVersionLocal_exe}"$\nRequestexecutionlevel user$\n'
!appendfile "${_GetVersionLocal_nsi}" 'Section$\n!define D "$"$\n!define N "${D}\n"$\n'
!appendfile "${_GetVersionLocal_nsi}" 'GetDLLVersion "${file}" $2 $4$\n'
!appendfile "${_GetVersionLocal_nsi}" 'IntOp $1 $2 / 0x00010000$\nIntOp $2 $2 & 0x0000FFFF$\n'
!appendfile "${_GetVersionLocal_nsi}" 'IntOp $3 $4 / 0x00010000$\nIntOp $4 $4 & 0x0000FFFF$\n'
!appendfile "${_GetVersionLocal_nsi}" 'FileOpen $0 "${_GetVersionLocal_nsi}" w$\nStrCpy $9 "${N}"$\n'
!appendfile "${_GetVersionLocal_nsi}" 'FileWrite $0 "!define ${basedef}1 $1$9"$\nFileWrite $0 "!define ${basedef}2 $2$9"$\n'
!appendfile "${_GetVersionLocal_nsi}" 'FileWrite $0 "!define ${basedef}3 $3$9"$\nFileWrite $0 "!define ${basedef}4 $4$9"$\n'
!appendfile "${_GetVersionLocal_nsi}" 'FileClose $0$\nSectionend$\n'
!system '"${NSISDIR}\makensis" -NOCD -NOCONFIG "${_GetVersionLocal_nsi}"' = 0
!system '"${_GetVersionLocal_exe}" /S' = 0
!delfile "${_GetVersionLocal_exe}"
!undef _GetVersionLocal_exe
!include "${_GetVersionLocal_nsi}"
!delfile "${_GetVersionLocal_nsi}"
!undef _GetVersionLocal_nsi
!verbose pop
!macroend

;--------------------------------
; 名称宏定义
!define PRODUCT_REQUIRED_SPACE    "80MB"

;--------------------------------
; OEM 中性

!define PRODUCT_NAME              "S-EYE"
!define PRODUCT_NAME_EN           "S-EYE"
!define PRODUCT_MAIN_EXE          "S-EYE.exe"
!define COMPANY_NAME              "S-EYE"
!define SUPPORT_URL               ""
!define HELP_URL                  ""
!define OEM_NAME                  ""
!define LICENCE_FILE_NAME         "Licence.txt"


;--------------------------------
; 仰望
/*
!define PRODUCT_NAME              "S-EYE"
!define PRODUCT_NAME_EN           "S-EYE"
!define PRODUCT_MAIN_EXE          "S-EYE.exe"
!define COMPANY_NAME              "YANGWANG"
!define SUPPORT_URL               "http://www.yangwangzhe.com"
!define HELP_URL                  "http://www.yangwangzhe.com"
!define OEM_NAME                  "-YW"
!define LICENCE_FILE_NAME         "Licence_yw.txt"
*/

;--------------------------------
; OEM TSI
/*
!define PRODUCT_NAME              "S-EYE"
!define PRODUCT_NAME_EN           "S-EYE"
!define PRODUCT_MAIN_EXE          "S-EYE.exe"
!define COMPANY_NAME              "TSI"
!define SUPPORT_URL               "http://www.3a-solusindo.com"
!define HELP_URL                  "http://www.3a-solusindo.com"
!define OEM_NAME                  "-TSI"
!define LICENCE_FILE_NAME         "Licence.txt"
*/

;--------------------------------
; OEM BLANG
/*
!define PRODUCT_NAME              "S-EYE"
!define PRODUCT_NAME_EN           "S-EYE"
!define PRODUCT_MAIN_EXE          "S-EYE.exe"
!define COMPANY_NAME              "BLANG"
!define SUPPORT_URL               ""
!define HELP_URL                  ""
!define OEM_NAME                  "-blang"
!define LICENCE_FILE_NAME         "Licence.txt"
*/

;--------------------------------
; OEM MARUTSU
/*
!define PRODUCT_NAME              "M-Live"
!define PRODUCT_NAME_EN           "M-Live"
!define PRODUCT_MAIN_EXE          "M-Live.exe"
!define COMPANY_NAME              "Marutsuelec"
!define SUPPORT_URL               "http://www.marutsu.co.jp"
!define HELP_URL                  "http://www.marutsu.co.jp"
!define OEM_NAME                  ""
!define LICENCE_FILE_NAME         "Licence_marutsu.txt"
*/

;--------------------------------
; OEM S-VIEW
/*
!define PRODUCT_NAME              "S-VIEW"
!define PRODUCT_NAME_EN           "S-VIEW"
!define PRODUCT_MAIN_EXE          "S-VIEW.exe"
!define COMPANY_NAME              "S-VIEW"
!define SUPPORT_URL               ""
!define HELP_URL                  ""
!define OEM_NAME                  ""
!define LICENCE_FILE_NAME         "Licence_sview.txt"
*/

!define PRODUCT_ROOT_KEY          "HKLM"
!define PRODUCT_SUB_KEY           "SOFTWARE\${COMPANY_NAME}\${PRODUCT_NAME_EN}"
!define UNINSTALL_SUB_KEY         "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"

!define PRODUCT_MAIN_EXE_MUTEX    "{4C4E6341-80EB-08B6-A5AB-3A4C48AAC515}"
!define SETUP_MUTEX_NAME          "{0F373A11-876A-4F74-9352-AA322CBB7283}"
!define PRODUCT_MAIN_CLASSNAME    "MainWnd"

!define 3RDPARTY_FOLDER           "..\..\..\nsis_files"
!define APPLICATION_FOLDER        "..\bin\release"
!define RESOURCE_FOLDER           ".\res"
!define MUI_ICON                  "${RESOURCE_FOLDER}\install.ico"    ; 安装icon
!define MUI_UNICON                "${RESOURCE_FOLDER}\uninstall.ico"  ; 卸载icon

; --------------------------------
; 变量
Var Dialog
Var MessageBoxHandle
Var DesktopIconState
Var FastIconState
Var FreeSpaceSize
Var InstallPath
Var timerID
Var timerID4Uninstall
Var changebkimageIndex
Var changebkimage4UninstallIndex
Var RunNow
Var InstallState
Var LocalPath
Var varTempFolder

!macro MutexCheck _mutexname _outvar _handle
System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${_mutexname}" ) i.r1 ?e'
StrCpy ${_handle} $1
Pop ${_outvar}
!macroend 

;Languages 
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "SimpChinese"

LangString STR_UNINSTALL                      ${LANG_ENGLISH}     "Uninstall"
LangString STR_UNINSTALL                      ${LANG_SIMPCHINESE} "卸载"

LangString STR_OVERWRITE                      ${LANG_ENGLISH}     "Over Write"
LangString STR_OVERWRITE                      ${LANG_SIMPCHINESE} "覆 盖"

LangString STR_UPGRADE                        ${LANG_ENGLISH}     "Upgrade"
LangString STR_UPGRADE                        ${LANG_SIMPCHINESE} "升 级"

LangString STR_ERR_INCORRECT_URL              ${LANG_ENGLISH}     "Incorrect URL, Please verify the URL and try again."
LangString STR_ERR_INCORRECT_URL              ${LANG_SIMPCHINESE} "错误的链接，请核对地址并重试。"

LangString STR_ALREADY_INSTALLED              ${LANG_ENGLISH}     "You have installed the current version of ${PRODUCT_NAME}, whether you want to overwrite the installation?"
LangString STR_ALREADY_INSTALLED              ${LANG_SIMPCHINESE} "您已经安装相同版本的 ${PRODUCT_NAME}，是否要覆盖安装？"

LangString STR_VERSION_TOOOLD                 ${LANG_ENGLISH}     "Newer version of ${PRODUCT_NAME} is already installed, if you need to use an older version, uninstall the existing version first."
LangString STR_VERSION_TOOOLD                 ${LANG_SIMPCHINESE} "您的计算机上已安装了新版本的 ${PRODUCT_NAME}，如果您需要使用旧版本，请卸载现有版本。"

LangString STR_SURE_TO_EXIT_INSTALL           ${LANG_ENGLISH}     "Are you sure you want to exit installation?"  
LangString STR_SURE_TO_EXIT_INSTALL           ${LANG_SIMPCHINESE} "你确定要退出安装程序吗？"

LangString STR_SURE_TO_EXIT_UNINSTALL         ${LANG_ENGLISH}     "Are you sure you want to exit the uninstaller?"  
LangString STR_SURE_TO_EXIT_UNINSTALL         ${LANG_SIMPCHINESE} "你确定要退出卸载程序吗？"

LangString STR_INSTALLATION_WIZARD            ${LANG_ENGLISH}     "${PRODUCT_NAME} Installation Wizard"
LangString STR_INSTALLATION_WIZARD            ${LANG_SIMPCHINESE} "${PRODUCT_NAME} 安装向导"

LangString STR_UNINSTALL_WIZARD               ${LANG_ENGLISH}     "${PRODUCT_NAME} Uninstall Wizard"
LangString STR_UNINSTALL_WIZARD               ${LANG_SIMPCHINESE} "${PRODUCT_NAME} 卸载向导"

LangString STR_APPLICATION_ALREADY_RUN_RETRY  ${LANG_ENGLISH}     "${PRODUCT_NAME} is running. Please close the program and try again."
LangString STR_APPLICATION_ALREADY_RUN_RETRY  ${LANG_SIMPCHINESE} "${PRODUCT_NAME} 程序正在运行，请关闭该程序后重试。"

LangString STR_ANOTHER_INSTALLATION_RUN_RETRY ${LANG_ENGLISH}     "Another Installation is in Progress you must complete the installation before continuing this one."
LangString STR_ANOTHER_INSTALLATION_RUN_RETRY ${LANG_SIMPCHINESE} "另一个安装程序正在进行，您必须在继续之前完成此安装程序。"

LangString STR_OS_LIMITION                    ${LANG_ENGLISH}     "Sorry, ${PRODUCT_NAME} only can be installed on Windows XP/Vista/7 and above."
LangString STR_OS_LIMITION                    ${LANG_SIMPCHINESE} "对不起，${PRODUCT_NAME} 目前仅可以安装在 Windows XP/Vista/7 及以上操作系统。"

LangString STR_INSUFFICIENT_DISK_SPACE        ${LANG_ENGLISH}     "Insufficient disk space."
LangString STR_INSUFFICIENT_DISK_SPACE        ${LANG_SIMPCHINESE} "磁盘空间不足。"

LangString STR_ADMIN_RIGHTS_REQUIRED          ${LANG_ENGLISH}     "Administrator rights required."
LangString STR_ADMIN_RIGHTS_REQUIRED          ${LANG_SIMPCHINESE} "需要管理员权限才能继续安装。"


!insertmacro GetVersionLocal "${APPLICATION_FOLDER}\${PRODUCT_MAIN_EXE}" MyVer_

; --------------------------------
; Version Information
VIProductVersion "${MyVer_1}.${MyVer_2}.${MyVer_3}.${MyVer_4}"
VIAddVersionKey /LANG=${LANG_ENGLISH}  "ProductName"      "${PRODUCT_NAME}"
;VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments"         "A test comment"
VIAddVersionKey /LANG=${LANG_ENGLISH}  "CompanyName"      "${COMPANY_NAME}"
;VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks"  "Test Application is a trademark of Fake company"
;VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright"    "${LEGAL_COPYRIGHT}"
;VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription"   "${FILE_DESCRIPTION}"
VIAddVersionKey /LANG=${LANG_ENGLISH}  "FileVersion"      "${MyVer_1}.${MyVer_2}.${MyVer_3}.${MyVer_4}"
VIAddVersionKey /LANG=${LANG_ENGLISH}  "ProductVersion"   "${MyVer_1}.${MyVer_2}.${MyVer_3}.${MyVer_4}"

Name      "${PRODUCT_NAME}"                                                ; 提示对话框的标题
OutFile   "..\..\..\nsis_packages\${PRODUCT_NAME_EN}_Setup-${MyVer_1}.${MyVer_2}.${MyVer_3}.${MyVer_4}${OEM_NAME}.exe"  ; 输出的安装包名

InstallDir "$PROGRAMFILES\${COMPANY_NAME}\${PRODUCT_NAME_EN}"          ;Default installation folder
InstallDirRegKey ${PRODUCT_ROOT_KEY} ${PRODUCT_SUB_KEY} "installDir"   ;Get installation folder from registry if available

RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)

;--------------------------------------------------------------------------------------------------------------------------------------------------------------
;Installer Sections

Section "Install Section" SecInstall

    ; disable close button
    nsTBCIASkinEngine::SetControlData "Wizard_CloseBtn" "false" "enable"

    ; copy 3rdparty files
    SetOutPath "$varTempFolder\${PRODUCT_NAME_EN}Setup\3rdparty"
    SetOverWrite on
    
    ; install vcredist_x86 2005
    File "${3RDPARTY_FOLDER}\vcredist_x86_2005.exe"
    ;ExecWait "$varTempFolder\${PRODUCT_NAME_EN}Setup\3rdparty\vcredist_x86_2005.exe /Q"
    ExecWait "$varTempFolder\${PRODUCT_NAME_EN}Setup\3rdparty\vcredist_x86_2005.exe /q:a /c:$\"msiexec /i vcredist.msi /qn /l*v $varTempFolder\vcredist_x86_2005.log$\""

	; install vcredist_x86 2008
    File "${3RDPARTY_FOLDER}\vcredist_x86_2008.exe"
    ExecWait "$varTempFolder\${PRODUCT_NAME_EN}Setup\3rdparty\vcredist_x86_2008.exe /q:a /c:$\"msiexec /i vcredist.msi /qn /l*v $varTempFolder\vcredist_x86_2008.log$\""
    
    ; install vcredist_x86 2013
    File "${3RDPARTY_FOLDER}\vcredist_x86_2013.exe"
    ExecWait '"$varTempFolder\${PRODUCT_NAME_EN}Setup\3rdparty\vcredist_x86_2013.exe" /q' $0
  
    ; install mjpg codec
  ;  SetOutPath "$INSTDIR\MJPEG Codec"
  ;  SetOverWrite on
  ;  File /r "${3RDPARTY_FOLDER}\MJPEG Codec\*.*"
  ;  ExecWait 'RunDll32 advpack.dll,LaunchINFSection "$INSTDIR\MJPEG Codec\mcmjpg.inf",DefaultInstall'
     
    ;复制要发布的安装文件  
    SetOutPath "$INSTDIR"
    SetOverWrite on
    File /r "${APPLICATION_FOLDER}\*.*"
  
    SetOverWrite on
    SetRebootFlag false
    
    WriteUninstaller "$INSTDIR\Uninstall.exe"   ;Create uninstaller
    Call BuildShortCut
    
    ; enable close button
    nsTBCIASkinEngine::SetControlData "Wizard_CloseBtn" "true" "enable"
SectionEnd
 
;--------------------------------------------------------------------------------------------------------------------------------------------------------------
;Uninstaller Section

Section "Uninstall"    
    ;Delete shortcuts
    Delete "$SMSTARTUP\${PRODUCT_NAME}.lnk"
    Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
    
;    ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" "CurrentVersion"
;    ${if} $R0 < 6.0
;        Delete "$QUICKLAUNCH\${PRODUCT_NAME}.lnk"
;    ${ElseIf} $R0 < 10.0
;        ExecShell taskbarunpin "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
;    ${EndIf} 

    SetShellVarContext all
    RMDir /r /REBOOTOK "$SMPROGRAMS\${PRODUCT_NAME}"

    SetShellVarContext current
    RMDir /r /REBOOTOK "$SMPROGRAMS\${PRODUCT_NAME}"


    SetRebootFlag false
    RMDir /r /REBOOTOK "$INSTDIR"
    DeleteRegKey ${PRODUCT_ROOT_KEY} "${PRODUCT_SUB_KEY}"

    SetRebootFlag false
    DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME_EN}"

    Delete "$INSTDIR\Uninstall.exe"
  
;  Sleep 30000
SectionEnd

;--------------------------------------------------------------------------------------------------------------------------------------------------------------

; 安装和卸载页面
Page         custom     pageInstall
Page         instfiles  "" InstallShow

UninstPage   custom     un.pageUninstall
UninstPage   instfiles  "" un.UninstallShow

;--------------------------------------------------------------------------------------------------------------------------------------------------------------

Function pageInstall
    ;初始化窗口     
    ${if} $LANGUAGE == "2052"
        nsTBCIASkinEngine::InitTBCIASkinEngine /NOUNLOAD "$varTempFolder\${PRODUCT_NAME_EN}Setup\res" "UIInstall_cn.xml" "WizardTab" "$(STR_INSTALLATION_WIZARD)"
        Pop $Dialog
    ${Else}
        nsTBCIASkinEngine::InitTBCIASkinEngine /NOUNLOAD "$varTempFolder\${PRODUCT_NAME_EN}Setup\res" "UIInstall_en.xml" "WizardTab" "$(STR_INSTALLATION_WIZARD)"
        Pop $Dialog
    ${endif}

    ;初始化MessageBox窗口
    nsTBCIASkinEngine::InitTBCIAMessageBox "MessageBox.xml" "TitleLab" "TextLab" "CloseBtn" "YESBtn" "NOBtn"
    Pop $MessageBoxHandle   

    ;全局按钮绑定函数
    ;最小化按钮绑定函数
    nsTBCIASkinEngine::FindControl "Wizard_MinBtn"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have min button"
    ${Else}
        GetFunctionAddress $0 OnGlobalMinFunc
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_MinBtn" $0
    ${EndIf}
    
    ;关闭按钮绑定函数
    nsTBCIASkinEngine::FindControl "Wizard_CloseBtn"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have close button"
    ${Else}
        GetFunctionAddress $0 OnGlobalCancelFunc
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_CloseBtn" $0
    ${EndIf}
    
    ; 窗口标题
    nsTBCIASkinEngine::FindControl "TitleTextLab"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have TitleTextLab button"
    ${Else}
        nsTBCIASkinEngine::SetControlData "TitleTextLab"  $(STR_INSTALLATION_WIZARD) "text"
    ${EndIf}
    

    ;----------------------------第一个页面-----------------------------------------------
    ; 显示licence
    nsTBCIASkinEngine::FindControl "LicenceRichEdit"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have LicenceRichEdit button"
    ${Else}
        nsTBCIASkinEngine::ShowLicense "LicenceRichEdit" ${LICENCE_FILE_NAME}     ;"许可协议控件名字" "许可协议文件名字"
    ${EndIf}

   ;下一步按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_NextBtn4Page1"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_NextBtn4Page1 button"
   ${Else}
    GetFunctionAddress $0 OnNextBtnFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_NextBtn4Page1"  $0
   ${EndIf}
   
   ;取消按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_CancelBtn4Page1"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_CancelBtn4Page1 button"
   ${Else}
    GetFunctionAddress $0 OnGlobalCancelFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_CancelBtn4Page1"  $0
   ${EndIf}
   
    ;----------------------------第二个页面-----------------------------------------------
    ;安装路径编辑框设定数据
    nsTBCIASkinEngine::FindControl "Wizard_InstallPathEdit4Page2"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have Wizard_InstallPathBtn4Page2 button"
    ${Else}
        ;nsTBCIASkinEngine::SetText2Control "Wizard_InstallPathEdit4Page2"  $InstallPath
        nsTBCIASkinEngine::SetControlData "Wizard_InstallPathEdit4Page2"  $InstallPath "text"

        GetFunctionAddress $0 OnTextChangeFunc
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_InstallPathEdit4Page2" $0
    ${EndIf}

    ${If} $InstallState == "Cover"
        ReadRegStr $LocalPath HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME_EN}" "InstallLocation"
        StrCmp $LocalPath "" +4 0
        nsTBCIASkinEngine::SetControlData "Wizard_InstallPathEdit4Page2"  $LocalPath "text"
        nsTBCIASkinEngine::SetControlData "Wizard_InstallPathEdit4Page2" "false" "enable"
        nsTBCIASkinEngine::SetControlData "Wizard_InstallPathBtn4Page2" "false" "enable"
        nsTBCIASkinEngine::SetControlData "Wizard_StartInstallBtn4Page2" "$(STR_OVERWRITE)" "text"
    ${ElseIf} $InstallState == "Upgrade"
        ReadRegStr $LocalPath HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME_EN}" "InstallLocation"
        StrCmp $LocalPath "" +4 0
        nsTBCIASkinEngine::SetControlData "Wizard_InstallPathEdit4Page2"  $LocalPath "text"
        nsTBCIASkinEngine::SetControlData "Wizard_InstallPathEdit4Page2" "false" "enable"
        nsTBCIASkinEngine::SetControlData "Wizard_InstallPathBtn4Page2" "false" "enable"
        nsTBCIASkinEngine::SetControlData "Wizard_StartInstallBtn4Page2" "$(STR_UPGRADE)" "text"
    ${EndIf}
     
    ; Required Space Size
    nsTBCIASkinEngine::FindControl "Wizard_RequiredSpaceLab4Page2"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have Wizard_RequiredSpaceLab4Page2 button"
    ${Else}
        nsTBCIASkinEngine::SetControlData "Wizard_RequiredSpaceLab4Page2"  ${PRODUCT_REQUIRED_SPACE}  "text"
    ${EndIf}   
   
    ;可用磁盘空间设定数据
    nsTBCIASkinEngine::FindControl "Wizard_UsableSpaceLab4Page2"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have Wizard_UsableSpaceLab4Page2 button"
    ${Else}
        nsTBCIASkinEngine::SetControlData "Wizard_UsableSpaceLab4Page2"  $FreeSpaceSize  "text"
    ${EndIf}   

   ;安装路径浏览按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_InstallPathBtn4Page2"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_InstallPathBtn4Page2 button"
   ${Else}
    GetFunctionAddress $0 OnInstallPathBrownBtnFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_InstallPathBtn4Page2"  $0
   ${EndIf}   

   ;创建桌面快捷方式绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_ShortCutBtn4Page2"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_ShortCutBtn4Page2 button"
   ${Else}
        StrCpy $DesktopIconState "1"
        GetFunctionAddress $0 OnDesktopIconStateFunc
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_ShortCutBtn4Page2"  $0
   ${EndIf}

   ;添加到快捷启动栏绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_QuickLaunchBarBtn4Page2"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_QuickLaunchBarBtn4Page2 button"
   ${Else}
        StrCpy $FastIconState "1"
    GetFunctionAddress $0 OnFastIconStateFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_QuickLaunchBarBtn4Page2"  $0
   ${EndIf}

   ;上一步按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_BackBtn4Page2"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_BackBtn4Page2 button"
   ${Else}
    GetFunctionAddress $0 OnBackBtnFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_BackBtn4Page2"  $0
   ${EndIf}

   ;开始安装按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_StartInstallBtn4Page2"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_StartInstallBtn4Page2 button"
   ${Else}
    GetFunctionAddress $0 OnStartInstallBtnFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_StartInstallBtn4Page2"  $0
   ${EndIf}

   ;取消按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_CancelBtn4Page2"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_CancelBtn4Page2 button"
   ${Else}
    GetFunctionAddress $0 OnGlobalCancelFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_CancelBtn4Page2"  $0
   ${EndIf}

   ;----------------------------第三个页面-----------------------------------------------
   ;取消按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_CancelBtn4Page3"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_CancelBtn4Page3 button"
   ${Else}
    GetFunctionAddress $0 OnGlobalCancelFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_CancelBtn4Page3"  $0
   ${EndIf}
   
   ; 禁止退出安装过程中
   nsTBCIASkinEngine::SetControlData "Wizard_CancelBtn4Page3" "false" "enable"
   

   ;切换背景绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_Background4Page3"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_Background4Page3 button"
   ${Else}
        StrCpy $changebkimageIndex  "0"
    GetFunctionAddress $timerID OnChangeFunc   
    nsTBCIASkinEngine::TBCIACreatTimer $timerID 3000  ;callback interval        
   ${EndIf}   
     
   ;----------------------------第四个页面-----------------------------------------------
   nsTBCIASkinEngine::FindControl "Wizard_RuningNowBtn"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_RuningNowBtn button"
   ${Else}
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_RuningNowBtn"  $0
   ${EndIf}

;   nsTBCIASkinEngine::FindControl "Wizard_BootRuningBtn"
;   Pop $0
;   ${If} $0 == "-1"
;    MessageBox MB_OK "Do not have Wizard_BootRuningBtn button"
;   ${Else}
;        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_BootRuningBtn"  $0
;   ${EndIf}
    
   ;完成按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_FinishedBtn4Page4"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_FinishedBtn4Page4 button"
   ${Else}
    GetFunctionAddress $0 OnFinishedBtnFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_FinishedBtn4Page4"  $0
   ${EndIf}

   ;链接按钮绑定函数
;   nsTBCIASkinEngine::FindControl "Wizard_110Btn4Page4"
;   Pop $0
;   ${If} $0 == "-1"
;    MessageBox MB_OK "Do not have Wizard_110Btn4Page4 button"
;   ${Else}
;    GetFunctionAddress $0 OnLinkBtnFunc    
;        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_110Btn4Page4"  $0
;   ${EndIf}

   ;---------------------------------显示------------------------------------------------
   nsTBCIASkinEngine::ShowPage
FunctionEnd

Function un.pageUninstall
    ;初始化窗口  
    ${if} $LANGUAGE == "2052"
        nsTBCIASkinEngine::InitTBCIASkinEngine /NOUNLOAD "$varTempFolder\${PRODUCT_NAME_EN}Setup\res" "UIUninstall_cn.xml" "WizardTab" "$(STR_UNINSTALL_WIZARD)"
        Pop $Dialog
    ${Else}
        nsTBCIASkinEngine::InitTBCIASkinEngine /NOUNLOAD "$varTempFolder\${PRODUCT_NAME_EN}Setup\res" "UIUninstall_en.xml" "WizardTab" "$(STR_UNINSTALL_WIZARD)"
        Pop $Dialog
    ${endif}

   ;初始化MessageBox窗口
   nsTBCIASkinEngine::InitTBCIAMessageBox "MessageBox.xml" "TitleLab" "TextLab" "CloseBtn" "YESBtn" "NOBtn"
   Pop $MessageBoxHandle   

   ;全局按钮绑定函数
   ;最小化按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_MinBtn"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have min button"
   ${Else}
    GetFunctionAddress $0 un.OnGlobalMinFunc
    nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_MinBtn" $0
   ${EndIf}
   ;关闭按钮绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_CloseBtn"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have close button"
   ${Else}
    GetFunctionAddress $0 un.OnGlobalCancelFunc
    nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_CloseBtn" $0
   ${EndIf}
   
   ; 窗口标题
    nsTBCIASkinEngine::FindControl "TitleTextLab"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have TitleTextLab button"
    ${Else}
        nsTBCIASkinEngine::SetControlData "TitleTextLab"  $(STR_UNINSTALL_WIZARD) "text"
    ${EndIf}

   ;-------------------------------------确定卸载页面------------------------------------
   ;开始卸载按钮绑定函数
   nsTBCIASkinEngine::FindControl "UninstallBtn4UninstallPage"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have UninstallBtn4UninstallPage button"
   ${Else}
    GetFunctionAddress $0 un.OnStartUninstallBtnFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "UninstallBtn4UninstallPage"  $0
   ${EndIf}

   ;取消按钮绑定函数
   nsTBCIASkinEngine::FindControl "CancelBtn4UninstallPage"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have CancelBtn4UninstallPage button"
   ${Else}
    GetFunctionAddress $0 un.OnGlobalCancelFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "CancelBtn4UninstallPage"  $0
   ${EndIf}

   ;切换背景绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_BackgroundUninstallPage"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_BackgroundUninstallPage button"
   ${Else}
        StrCpy $changebkimage4UninstallIndex  "0"
    GetFunctionAddress $timerID4Uninstall un.OnChangeFunc   
    nsTBCIASkinEngine::TBCIACreatTimer $timerID4Uninstall 3000  ;callback interval        
   ${EndIf}   

    ;--------------------------------卸载完成页面----------------------------------------
   ;完成按钮绑定函数
   nsTBCIASkinEngine::FindControl "FinishedBtn4UninstallPage"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have FinishedBtn4UninstallPage button"
   ${Else}
    GetFunctionAddress $0 un.OnUninstallFinishedBtnFunc    
        nsTBCIASkinEngine::OnControlBindNSISScript "FinishedBtn4UninstallPage"  $0
   ${EndIf}

   ;链接按钮绑定函数
;   nsTBCIASkinEngine::FindControl "Wizard_110Btn4UninstallPage"
;   Pop $0
;   ${If} $0 == "-1"
;    MessageBox MB_OK "Do not have Wizard_110Btn4UninstallPage button"
;   ${Else}
;    GetFunctionAddress $0 un.OnLinkBtnFunc    
;        nsTBCIASkinEngine::OnControlBindNSISScript "Wizard_110Btn4UninstallPage"  $0
;   ${EndIf}

   nsTBCIASkinEngine::ShowPage   

FunctionEnd

;--------------------------------------------------------------------------------------------------------------------------------------------------------------
; 函数的定义

Function .onInit
    UserInfo::GetAccountType
    pop $0
    ${If} $0 != "admin" ;Require admin rights on NT4+
        MessageBox mb_iconstop "$(STR_ADMIN_RIGHTS_REQUIRED)"  
        SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
        Quit
    ${EndIf}

    GetTempFileName $0
    StrCpy $varTempFolder $0
    Delete $0
    SetOutPath $varTempFolder\${PRODUCT_NAME_EN}Setup\res
    File "${RESOURCE_FOLDER}\*.png"
    File "${RESOURCE_FOLDER}\*.txt"
    File "${RESOURCE_FOLDER}\*.xml"

  StrCpy $InstallPath "$PROGRAMFILES\${COMPANY_NAME}\${PRODUCT_NAME_EN}"
  Call UpdateFreeSpace
  
  FindWindow $0 "${PRODUCT_MAIN_CLASSNAME}" "${PRODUCT_NAME}"  ;判断客户端是否在运行中
  ;Dumpstate::debug
  IsWindow $0 0 +5  
     MessageBox MB_RETRYCANCEL "$(STR_APPLICATION_ALREADY_RUN_RETRY)" IDRETRY RetryInstall  IDCANCEL NotInstall
     RetryInstall:
       Goto -4;
     NotInstall:
       Goto +1     
  Goto close_run_cancel

  ; 判断mutex 知道是否还有安装卸载程序运行
  !insertmacro MutexCheck "${SETUP_MUTEX_NAME}" $0 $9
  StrCmp $0 0 launch
  MessageBox MB_OK "$(STR_ANOTHER_INSTALLATION_RUN_RETRY)"
  Abort
  StrLen $0 "$(^Name)"
  IntOp $0 $0 + 1

 loop:
   FindWindow $1 '#32770' '' 0 $1
   StrCmp $1 0 +1 +2
   IntOp $3 $3 + 1
   IntCmp $3 3 +5
   System::Call "user32::GetWindowText(i r1, t .r2, i r0) i."
   StrCmp $2 "$(^Name)" 0 loop
   System::Call "user32::SetForegroundWindow(i r1) i."
   System::Call "user32::ShowWindow(i r1,i 9) i."
   Abort

 launch: 
  ; 判断操作系统
  Call GetWindowsVersion
  Pop $R0
  StrCmp $R0 "98"   done
  StrCmp $R0 "2000" done
   Goto End
  done:
     MessageBox MB_OK "$(STR_OS_LIMITION)"
     Abort
  End:  
  
  ; 检查版本
  ReadRegStr $0 ${PRODUCT_ROOT_KEY} "${PRODUCT_SUB_KEY}" "Version"
  
  Var /Global local_check_version
  ${VersionCompare} "${MyVer_1}.${MyVer_2}.${MyVer_3}.${MyVer_4}" "$0" $local_check_version
  
    ; 覆盖安装
    ${If} $0 != ""
        ;相同版本
        ${If} $local_check_version == "0"
            StrCmp $local_check_version "0" 0 +4
            MessageBox MB_YESNO "$(STR_ALREADY_INSTALLED)" IDYES true IDNO false
            true:
                StrCpy $InstallState "Cover"
                Goto CHECK_RUN
            false: 
                Quit
        ;安装包版本较低
        ${ElseIf} $local_check_version == "2"
            MessageBox MB_OK|MB_ICONINFORMATION "$(STR_VERSION_TOOOLD)"
            Quit
        ;安装包版本较高
        ${Else}
            StrCpy $InstallState "Upgrade"
            Goto CHECK_RUN
        ${EndIf}    
  ${EndIf}

  ;判断进程是否存在
    CHECK_RUN:
        Push "${PRODUCT_MAIN_EXE_MUTEX}"
        nsInstallAssist::CheckRun
        Pop $R0
        StrCmp $R0 "run" 0 NO_RUNNING_PROCESS
        MessageBox MB_RETRYCANCEL|MB_ICONINFORMATION "$(STR_APPLICATION_ALREADY_RUN_RETRY)" IDRETRY close_run_retry IDCANCEL close_run_cancel
    close_run_retry:
        Goto CHECK_RUN
    close_run_cancel:
        Quit
    NO_RUNNING_PROCESS:
  
  SectionGetSize ${SecInstall} $1
  
  ${GetRoot} $varTempFolder $0
  System::Call kernel32::GetDiskFreeSpaceEx(tr0,*l,*l,*l.r0)
  System::Int64Op $0 / 1024
  Pop $2
  IntCmp $2 $1 "" "" +3
  MessageBox MB_OK|MB_ICONEXCLAMATION "$(STR_INSUFFICIENT_DISK_SPACE)"
  Quit  
FunctionEnd

Function .onGUIEnd
    RMDir /r $varTempFolder\${PRODUCT_NAME_EN}Setup
    IfFileExists $varTempFolder\${PRODUCT_NAME_EN}Setup 0 +2
        RMDir /r /REBOOTOK $varTempFolder\${PRODUCT_NAME_EN}Setup
    RMDir /r /REBOOTOK "$varTempFolder"
FunctionEnd

Function BuildShortCut
    ;开始菜单
    CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
    CreateShortCut  "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}"
    CreateShortCut  "$SMPROGRAMS\${PRODUCT_NAME}\$(STR_UNINSTALL) ${PRODUCT_NAME}.lnk   "$INSTDIR\Uninstall.exe"   

    ;桌面快捷方式
    StrCmp $DesktopIconState "1" "" +2
    CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}"

    ; 快速启动
;    ReadRegStr $R0 HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" "CurrentVersion"
;    ${if} $R0 < 6.0
;        StrCmp $FastIconState "1" "" +2
;        CreateShortCut "$QUICKLAUNCH\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}"
;    ${ElseIf} $R0 < 10.0
;        ExecShell taskbarpin "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk"
;    ${EndIf} 
  
    ;注册表
    WriteRegStr ${PRODUCT_ROOT_KEY} "${PRODUCT_SUB_KEY}" "Version" "${MyVer_1}.${MyVer_2}.${MyVer_3}.${MyVer_4}"

    ;控制面板卸载连接
    WriteRegStr ${PRODUCT_ROOT_KEY} "${UNINSTALL_SUB_KEY}\${PRODUCT_NAME_EN}" "DisplayName" "${PRODUCT_NAME}"
    WriteRegStr ${PRODUCT_ROOT_KEY} "${UNINSTALL_SUB_KEY}\${PRODUCT_NAME_EN}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
    WriteRegStr ${PRODUCT_ROOT_KEY} "${UNINSTALL_SUB_KEY}\${PRODUCT_NAME_EN}" "DisplayIcon" '"$INSTDIR\${PRODUCT_MAIN_EXE}"'
    WriteRegStr ${PRODUCT_ROOT_KEY} "${UNINSTALL_SUB_KEY}\${PRODUCT_NAME_EN}" "InstallLocation" "$INSTDIR"
    WriteRegStr ${PRODUCT_ROOT_KEY} "${UNINSTALL_SUB_KEY}\${PRODUCT_NAME_EN}" "Publisher" "${COMPANY_NAME}" 
    WriteRegStr ${PRODUCT_ROOT_KEY} "${UNINSTALL_SUB_KEY}\${PRODUCT_NAME_EN}" "HelpLink" "${HELP_URL}"
    WriteRegStr ${PRODUCT_ROOT_KEY} "${UNINSTALL_SUB_KEY}\${PRODUCT_NAME_EN}" "DisplayVersion" "${MyVer_1}.${MyVer_2}.${MyVer_3}.${MyVer_4}"
FunctionEnd



Function un.onInit
    GetTempFileName $0
    StrCpy $varTempFolder $0
    Delete $0
    SetOutPath $varTempFolder\${PRODUCT_NAME_EN}Setup\res
    File "${RESOURCE_FOLDER}\*.png"
    File "${RESOURCE_FOLDER}\*.txt"
    File "${RESOURCE_FOLDER}\*.xml"

    ;判断客户端是否在运行中
    FindWindow $0 "${PRODUCT_MAIN_CLASSNAME}" "${PRODUCT_NAME}"
    ;Dumpstate::debug
    IsWindow $0 0 +5  
    MessageBox MB_RETRYCANCEL "$(STR_APPLICATION_ALREADY_RUN_RETRY)" IDRETRY RetryUninstall  IDCANCEL NotUninstall
        RetryUninstall:
            Goto -3;
        NotUninstall:
            Goto +1     
    Goto close_run_cancel
  
    ; 判断mutex 知道是否还有安装卸载程序运行
    !insertmacro MutexCheck "${SETUP_MUTEX_NAME}" $0 $9
    StrCmp $0 0 launch
    MessageBox MB_OK "$(STR_ANOTHER_INSTALLATION_RUN_RETRY)"
    Goto close_run_cancel
    StrLen $0 "$(^Name)"
    IntOp $0 $0 + 1

loop:
    FindWindow $1 '#32770' '' 0 $1
    StrCmp $1 0 +1 +2
    IntOp $3 $3 + 1
    IntCmp $3 3 +5
    System::Call "user32::GetWindowText(i r1, t .r2, i r0) i."
    StrCmp $2 "$(^Name)" 0 loop
    System::Call "user32::SetForegroundWindow(i r1) i."
    System::Call "user32::ShowWindow(i r1,i 9) i."
    Abort
launch: 
  ;判断进程是否存在
  CHECK_RUN:
    Push "${PRODUCT_MAIN_EXE_MUTEX}"
    nsInstallAssist::CheckRun
    Pop $R0
    StrCmp $R0 "run" 0 NO_RUNNING_PROCESS
    MessageBox MB_RETRYCANCEL|MB_ICONINFORMATION "$(STR_APPLICATION_ALREADY_RUN_RETRY)" IDRETRY close_run_retry IDCANCEL close_run_cancel

close_run_retry:
    Goto CHECK_RUN
close_run_cancel:
    Quit
NO_RUNNING_PROCESS:
FunctionEnd

Function un.onGUIEnd
    RMDir /r $varTempFolder\${PRODUCT_NAME_EN}Setup
    IfFileExists $varTempFolder\${PRODUCT_NAME_EN}Setup 0 +2
        RMDir /r /REBOOTOK $varTempFolder\${PRODUCT_NAME_EN}Setup
    RMDir /r /REBOOTOK "$varTempFolder"
FunctionEnd

Function OnGlobalMinFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAMIN
FunctionEnd

Function OnGlobalCancelFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIACANCEL "$(STR_INSTALLATION_WIZARD)" "$(STR_SURE_TO_EXIT_INSTALL)"
   Pop $0
   ${If} $0 == "0"
     nsTBCIASkinEngine::ExitTBCIASkinEngine
   ${EndIf}
FunctionEnd

Function un.OnGlobalMinFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAMIN
FunctionEnd

Function un.OnGlobalCancelFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIACANCEL "$(STR_UNINSTALL_WIZARD)" "$(STR_SURE_TO_EXIT_UNINSTALL)"
   Pop $0
   ${If} $0 == "0"
     nsTBCIASkinEngine::ExitTBCIASkinEngine
   ${EndIf}
FunctionEnd

Function OnBackBtnFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIABACK
FunctionEnd

Function OnNextBtnFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIANEXT
FunctionEnd

Function OnStartInstallBtnFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIASTARTINSTALL
FunctionEnd

Function un.OnStartUninstallBtnFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIASTARTUNINSTALL
FunctionEnd

Function RunAfterInstall
    StrCmp $RunNow "1" "" +2
    Exec '"$INSTDIR\${PRODUCT_MAIN_EXE}"'
FunctionEnd

Function OnFinishedBtnFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAOPTIONSTATE "Wizard_RuningNowBtn" ""
   Pop $0
   ${If} $0 == "1"
     StrCpy $RunNow "1"
   ${Else}
     StrCpy $RunNow "0" 
   ${EndIf}

;   ;开机运行
;   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAOPTIONSTATE "Wizard_BootRuningBtn" ""
;   Pop $0
;   ${If} $0 == "1"
;      ;CreateShortCut "$SMSTARTUP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_MAIN_EXE}" "" "$INSTDIR\${PRODUCT_MAIN_EXE}" 0
;      WriteRegStr HKLM  "Software\Microsoft\Windows\CurrentVersion\Run" "${PRODUCT_NAME_EN}"  "$INSTDIR\${PRODUCT_MAIN_EXE} -autorun"
;   ${EndIf}

   call RunAfterInstall
   nsTBCIASkinEngine::TBCIAKillTimer $timerID
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAFINISHEDINSTALL
FunctionEnd

Function un.OnUninstallFinishedBtnFunc
   DeleteRegValue HKLM  "Software\Microsoft\Windows\CurrentVersion\Run" "${PRODUCT_NAME_EN}"
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAFINISHEDINSTALL
;   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAOPENURL "${SUPPORT_URL}"
FunctionEnd

;Function OnLinkBtnFunc
;   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAOPENURL "${SUPPORT_URL}"
;   Pop $0
;   ${If} $0 == "url error"
;     MessageBox MB_OK "$(STR_ERR_INCORRECT_URL)"
;   ${EndIf}
;FunctionEnd

Function OnTextChangeFunc
    ; 改变可用磁盘空间大小
    nsTBCIASkinEngine::GetControlData Wizard_InstallPathEdit4Page2 "text"
    Pop $0
    ;MessageBox MB_OK $0
    StrCpy $INSTDIR $0

    ;重新获取磁盘空间
    Call UpdateFreeSpace

    ;更新磁盘空间文本显示
    nsTBCIASkinEngine::FindControl "Wizard_UsableSpaceLab4Page2"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have Wizard_UsableSpaceLab4Page2 button"
    ${Else}
        ;nsTBCIASkinEngine::SetText2Control "Wizard_UsableSpaceLab4Page2"  $FreeSpaceSize
        nsTBCIASkinEngine::SetControlData "Wizard_UsableSpaceLab4Page2"  $FreeSpaceSize  "text"
    ${EndIf}
    
    ;路径是否合法（合法则不为0Bytes）
    ${If} $FreeSpaceSize == "0Bytes"
        nsTBCIASkinEngine::SetControlData "Wizard_StartInstallBtn4Page2" "false" "enable"
    ${Else}
        nsTBCIASkinEngine::SetControlData "Wizard_StartInstallBtn4Page2" "true" "enable"
    ${EndIf}
FunctionEnd

Function OnChangeFunc
    ${If} $changebkimageIndex == "0"
        StrCpy $changebkimageIndex "1"
        nsTBCIASkinEngine::SetControlData "Wizard_Background4Page3" "install_bg_0.png" "bkimage"
    ${ElseIF} $changebkimageIndex == "1"
        StrCpy $changebkimageIndex "2"
        nsTBCIASkinEngine::SetControlData "Wizard_Background4Page3" "install_bg_1.png" "bkimage"
   ${Else}
        StrCpy $changebkimageIndex "0"
        nsTBCIASkinEngine::SetControlData "Wizard_Background4Page3" "install_bg_2.png" "bkimage"
   ${EndIf}

FunctionEnd

Function OnDesktopIconStateFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAOPTIONSTATE "Wizard_ShortCutBtn4Page2" ""
   Pop $0
   ${If} $0 == "1"
     StrCpy $DesktopIconState "1"
   ${Else}
     StrCpy $DesktopIconState "0" 
   ${EndIf}
FunctionEnd

Function OnFastIconStateFunc
   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAOPTIONSTATE "Wizard_QuickLaunchBarBtn4Page2" ""
   Pop $1
   ${If} $1 == "1"
      StrCpy $FastIconState "1"
   ${Else}
      StrCpy $FastIconState "0"
   ${EndIf}
FunctionEnd

Function OnInstallPathBrownBtnFunc
   nsTBCIASkinEngine::SelectFolderDialog "请选择文件夹" 
   Pop $InstallPath

   StrCpy $0 $InstallPath
   ${If} $0 == "-1"
   ${Else}
      StrCpy $INSTDIR "$InstallPath\${PRODUCT_NAME_EN}"
      ;设置安装路径编辑框文本
      nsTBCIASkinEngine::FindControl "Wizard_InstallPathEdit4Page2"
      Pop $0
      ${If} $0 == "-1"
     MessageBox MB_OK "Do not have Wizard_InstallPathBtn4Page2 button"
      ${Else}
     ;nsTBCIASkinEngine::SetText2Control "Wizard_InstallPathEdit4Page2"  $InstallPath
     StrCpy $InstallPath $INSTDIR
     nsTBCIASkinEngine::SetControlData "Wizard_InstallPathEdit4Page2"  $InstallPath  "text"
      ${EndIf}
   ${EndIf}

    ;重新获取磁盘空间
    Call UpdateFreeSpace

    ;路径是否合法（合法则不为0Bytes）
    ${If} $FreeSpaceSize == "0Bytes"
        nsTBCIASkinEngine::SetControlData "Wizard_StartInstallBtn4Page2" "false" "enable"
    ${Else}
        nsTBCIASkinEngine::SetControlData "Wizard_StartInstallBtn4Page2" "true" "enable"
    ${EndIf}

    ;更新磁盘空间文本显示
    nsTBCIASkinEngine::FindControl "Wizard_UsableSpaceLab4Page2"
    Pop $0
    ${If} $0 == "-1"
        MessageBox MB_OK "Do not have Wizard_UsableSpaceLab4Page2 button"
    ${Else}
        ;nsTBCIASkinEngine::SetText2Control "Wizard_UsableSpaceLab4Page2"  $FreeSpaceSize
        nsTBCIASkinEngine::SetControlData "Wizard_UsableSpaceLab4Page2"  $FreeSpaceSize  "text"
    ${EndIf}
FunctionEnd

Function UpdateFreeSpace
  ${GetRoot} $INSTDIR $0
  StrCpy $1 "Bytes"

  System::Call kernel32::GetDiskFreeSpaceEx(tr0,*l,*l,*l.r0)
   ${If} $0 > 1024
   ${OrIf} $0 < 0
      System::Int64Op $0 / 1024
      Pop $0
      StrCpy $1 "KB"
      ${If} $0 > 1024
      ${OrIf} $0 < 0
     System::Int64Op $0 / 1024
     Pop $0
     StrCpy $1 "MB"
     ${If} $0 > 1024
     ${OrIf} $0 < 0
        System::Int64Op $0 / 1024
        Pop $0
        StrCpy $1 "GB"
     ${EndIf}
      ${EndIf}
   ${EndIf}

   StrCpy $FreeSpaceSize  "$0$1"
FunctionEnd

Function InstallShow
   ;进度条绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_InstallProgress"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_InstallProgress button"
   ${Else}
    nsTBCIASkinEngine::StartInstall  Wizard_InstallProgress
   ${EndIf}   
FunctionEnd 

Function un.UninstallShow 
   ;进度条绑定函数
   nsTBCIASkinEngine::FindControl "Wizard_UninstallProgress"
   Pop $0
   ${If} $0 == "-1"
    MessageBox MB_OK "Do not have Wizard_InstallProgress button"
   ${Else}
    nsTBCIASkinEngine::StartUninstall  Wizard_UninstallProgress
   ${EndIf} 
FunctionEnd

;Function un.OnLinkBtnFunc
;   nsTBCIASkinEngine::TBCIASendMessage $Dialog WM_TBCIAOPENURL "${SUPPORT_URL}"
;   Pop $0
;   ${If} $0 == "url error"
;     MessageBox MB_OK "url error"
;   ${EndIf}
;FunctionEnd

Function un.OnChangeFunc
   ${If} $changebkimage4UninstallIndex == "0"
        StrCpy $changebkimage4UninstallIndex "1"
        nsTBCIASkinEngine::SetControlData "Wizard_BackgroundUninstallPage" "install_bg_0.png" "bkimage"
   ${ElseIf} $changebkimage4UninstallIndex == "1"
        StrCpy $changebkimage4UninstallIndex "2"
        nsTBCIASkinEngine::SetControlData "Wizard_BackgroundUninstallPage" "install_bg_1.png" "bkimage"
   ${Else}
        StrCpy $changebkimage4UninstallIndex "0"
        nsTBCIASkinEngine::SetControlData "Wizard_BackgroundUninstallPage" "install_bg_2.png" "bkimage"
   ${EndIf}
FunctionEnd