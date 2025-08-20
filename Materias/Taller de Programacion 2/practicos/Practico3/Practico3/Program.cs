using System;
using System.Windows.Forms;

namespace Practico3
{
    internal static class Program
    {
        [STAThread]
        static void Main()
        {
            ApplicationConfiguration.Initialize();

            var mdi = new MDIParent1();

            // Abrir el formulario hijo automáticamente al iniciar
            mdi.Shown += (_, __) =>
            {
                var frm = new Form1
                {
                    MdiParent = mdi,
                    StartPosition = FormStartPosition.CenterParent
                };
                frm.Show();
            };

            Application.Run(mdi);
        }
    }
}
