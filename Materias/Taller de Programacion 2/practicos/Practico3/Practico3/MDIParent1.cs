using System;
using System.Drawing;
using System.Windows.Forms;

namespace Practico3
{
    public partial class MDIParent1 : Form
    {
        public MDIParent1()
        {
            InitializeComponent();

            // (Opcional) Color del fondo MDI tipo “Gainsboro”
            foreach (Control c in Controls)
                if (c is MdiClient m) m.BackColor = Color.Gainsboro;
        }

        private void menuNuevoPequenoFormulario_Click(object? sender, EventArgs e)
        {
            var frm = new Form1
            {
                MdiParent = this,
                StartPosition = FormStartPosition.CenterParent
            };
            frm.Show();
        }

        private void menuSalir_Click(object? sender, EventArgs e)
        {
            Close(); // o Application.Exit();
        }
    }
}
