using System;
using System.Windows.Forms;

namespace Practico4
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            ApplicationConfiguration.Initialize(); 
            Application.Run(new Form1());
        }
    }
}
