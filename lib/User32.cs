using System;
using System.Runtime.InteropServices;
using BOOL = System.Boolean;
using DWORD = System.UInt32;
using HANDLE = System.IntPtr;
using HWND = System.IntPtr;
using LPARAM = System.IntPtr;
using LPCWSTR = System.String;
using LPWSTR = System.Text.StringBuilder;
using LRESULT = System.IntPtr;
using UINT = System.UInt32;
using WPARAM = System.UIntPtr;

public class User32
{
	public delegate BOOL WNDENUMPROC(HWND hwnd, LPARAM lParam);

	[DllImport("user32.dll", SetLastError = true)]
	public static extern BOOL EnumWindows(WNDENUMPROC lpEnumFunc, LPARAM lParam);

	[DllImport("user32.dll")]
	public static extern HANDLE GetProp(HWND hWnd, LPCWSTR lpString);

	[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
	public static extern int GetWindowText(HWND hWnd, LPWSTR lpString, int nMaxCount);

	[DllImport("user32.dll", SetLastError = true)]
	public static extern int GetWindowTextLength(HWND hWnd);

	[DllImport("user32.dll", SetLastError = true)]
	public static extern DWORD GetWindowThreadProcessId(HWND hWnd, out DWORD lpdwProcessId);

	[DllImport("user32.dll", SetLastError = true)]
	public static extern HANDLE RemoveProp(HWND hWnd, LPCWSTR lpString);

	[DllImport("user32.dll", SetLastError = true)]
	public static extern LRESULT SendMessage(HWND hWnd, UINT Msg, WPARAM wParam, LPARAM lParam);
}
