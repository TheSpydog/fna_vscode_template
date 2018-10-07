using System;
using System.IO;
using System.Runtime.InteropServices;
using Microsoft.Xna.Framework;

namespace project_name
{
    class Program
    {
        [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool SetDefaultDllDirectories(int directoryFlags);

        [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
        static extern void AddDllDirectory(string lpPathName);

        [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool SetDllDirectory(string lpPathName);

        const int LOAD_LIBRARY_SEARCH_DEFAULT_DIRS = 0x00001000;

        public static void Main(string[] args)
        {
            if (Environment.OSVersion.Platform == PlatformID.Win32NT)
            {
                try
                {
                    SetDefaultDllDirectories(LOAD_LIBRARY_SEARCH_DEFAULT_DIRS);
                    AddDllDirectory(Path.Combine(
                        AppDomain.CurrentDomain.BaseDirectory,
                        Environment.Is64BitProcess ? "x64" : "x86"
                    ));
                }
                catch
                {
                    // Pre-Windows 7, KB2533623 
                    SetDllDirectory(Path.Combine(
                        AppDomain.CurrentDomain.BaseDirectory,
                        Environment.Is64BitProcess ? "x64" : "x86"
                    ));
                }
            }

            using (Game1 game = new Game1())
            {
                game.Run();
            }
        }
    }
}