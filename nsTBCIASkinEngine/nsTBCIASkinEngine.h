#ifndef __NSTBCIASKINENGINE_H__
#define __NSTBCIASKINENGINE_H__
#pragma  once

#include "UIlib.h"
#include "stdafx.h"
#include "pluginapi.h"
#include <windows.h>
#include "MsgDef.h"

/* ������ 1. skin��·�������setup.exe���ɵ�·����
  *           2. skin�����ļ���
  *           3. ��װҳ��tab������
  * ���ܣ� ��ʼ������
*/
DLLEXPORT void InitTBCIASkinEngine(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. control������
  * ���ܣ� Ѱ���ض���control�Ƿ����
*/
DLLEXPORT void FindControl(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. richedit control������
  *           2. ���Э���ļ�����
  * ���ܣ� ��ʾ���֤�ļ�
*/
DLLEXPORT void ShowLicense(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. ��click�¼���control������
  *           2. ���Э���ļ�����
  * ���ܣ� Ϊ�ؼ��󶨶�Ӧ���¼�����click��Ϣʱִ�ж�Ӧ����
*/
DLLEXPORT void  OnControlBindNSISScript(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. control������
  *           2. ����control������
  *  		   3. ���ݵ����� (�����ṩ�����������ͣ� 1. text; 2. bkimage; 3. link; 4. enable )
  * ���ܣ� Ϊ�ؼ��󶨶�Ӧ���¼�����click��Ϣʱִ�ж�Ӧ����
*/
DLLEXPORT void  SetControlData(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. control������
  *           2. ���ݵ����� (�����ṩһ���������ͣ� 1. text; )
  * ���ܣ� Ϊ�ؼ��󶨶�Ӧ���¼�����click��Ϣʱִ�ж�Ӧ����
*/
DLLEXPORT void  GetControlData(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. TimerID(һ���ǻص�������ID)
  *           2. interval
  * ���ܣ� ������ʱ��
*/
DLLEXPORT void  TBCIACreatTimer(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. TimerID(һ���ǻص�������ID)
  * ���ܣ� ɱ����ʱ��
*/
DLLEXPORT void  TBCIAKillTimer(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. ��ϢHWND
  *            2. ��ϢID
  *			   3. WPARAM
  *			   4. LPARAM
  * ���ܣ� ����Ϣ
*/
DLLEXPORT void  TBCIASendMessage(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. ���⣨���磺 ��ѡ���ļ��У�
  * ���ܣ� ����Ϣ
*/
DLLEXPORT void  SelectFolderDialog(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. ��Ӧ��ʼ��װ���ȵĽ���������
  * ���ܣ� ��ʼ��װ��Ӧ
*/
DLLEXPORT void  StartInstall(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. ��Ӧ��ʼж�ؽ��ȵĽ���������
  * ���ܣ� ��ʼ��װ��Ӧ
*/
DLLEXPORT void  StartUninstall(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ ��
  * ���ܣ� ��ʾ���棨ע�⣺һ��������Show������
*/
DLLEXPORT void  ShowPage(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ ��
  * ���ܣ� �˳���װ
*/
DLLEXPORT void  ExitTBCIASkinEngine(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

/* ������ 1. �����ļ�������
               2. ����ؼ�����
			   3. ��ʾ���ݿؼ�����
			   4. �رհ�ť�ؼ�����
			   5. ȷ����ť�ؼ�����
			   6. ȡ����ť�ؼ�����
  * ���ܣ� ��ʼ��MessageBox
*/
DLLEXPORT void  InitTBCIAMessageBox(HWND hwndParent, int string_size, char *variables, stack_t **stacktop, extra_parameters *extra);

#endif



