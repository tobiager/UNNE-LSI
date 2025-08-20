using System;
using System.Drawing;
using System.Windows.Forms;

namespace Practico3
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            Text = "Pequeño Formulario";
            PrepararImagenesDeBotones();
            RBVaron.Checked = true; // por defecto
        }

        private void TDni_KeyPress(object? sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
                e.Handled = true;
        }

        private void SoloLetras_KeyPress(object? sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsLetter(e.KeyChar) && e.KeyChar != ' ')
                e.Handled = true;
        }

        private void SoloNumeros_KeyPress(object? sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
                e.Handled = true;
        }

        private void ActualizarNyA(object? sender, EventArgs e)
        {
            LNyA.Text = $"Nombre y Apellido: {TNombre.Text} {TApellido.Text}".Trim();
        }

        private void BGuardar_Click(object? sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TDni.Text) ||
                string.IsNullOrWhiteSpace(TNombre.Text) ||
                string.IsNullOrWhiteSpace(TApellido.Text) ||
                string.IsNullOrWhiteSpace(TCelular.Text))
            {
                MessageBox.Show("Debe completar todos los campos", "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            var ask = MessageBox.Show(
                "¿Seguro que desea insertar un nuevo Cliente?",
                "Confirmar Inserción",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Question,
                MessageBoxDefaultButton.Button1);

            if (ask == DialogResult.Yes)
            {
                string nya = $"{TNombre.Text} {TApellido.Text}".Trim();
                MessageBox.Show($"El Cliente: {nya} se insertó correctamente", "Guardar",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);

                LModificar.Text = $"Última acción: Guardado ({DateTime.Now:dd/MM/yyyy HH:mm})";
                LModificar.ForeColor = Color.Red;
            }
        }

        private void BEliminar_Click(object? sender, EventArgs e)
        {
            string nya = $"{TNombre.Text} {TApellido.Text}".Trim();
            if (string.IsNullOrWhiteSpace(nya)) nya = "(sin nombre)";

            var ask = MessageBox.Show(
                $"Está a punto de eliminar el Cliente: {nya}",
                "Confirmar Eliminación",
                MessageBoxButtons.YesNo,
                MessageBoxIcon.Exclamation,
                MessageBoxDefaultButton.Button2);

            if (ask == DialogResult.Yes)
            {
                TDni.Clear();
                TNombre.Clear();
                TApellido.Clear();
                TCelular.Clear();
                LNyA.Text = "Nombre y Apellido:";
                LModificar.Text = string.Empty;

                MessageBox.Show($"El Cliente: {nya} se eliminó correctamente", "Eliminar",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void BSalir_Click(object? sender, EventArgs e) => Close();

        private void RBVaron_CheckedChanged(object? sender, EventArgs e)
        {
            if (RBVaron.Checked) PBIcono.BackgroundImage = DibujarGenero(true);
        }

        private void RBMujer_CheckedChanged(object? sender, EventArgs e)
        {
            if (RBMujer.Checked) PBIcono.BackgroundImage = DibujarGenero(false);
        }

        private Image DibujarGenero(bool varon)
        {
            int w = PBIcono.Width > 0 ? PBIcono.Width : 160;
            int h = PBIcono.Height > 0 ? PBIcono.Height : 160;

            var bmp = new Bitmap(w, h);
            using var g = Graphics.FromImage(bmp);
            g.Clear(Color.White);
            var color = varon ? Color.SteelBlue : Color.HotPink;

            using var brush = new SolidBrush(color);
            using var pen = new Pen(color, 8);
            g.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;

            int r = Math.Min(w, h) - 24;
            g.DrawEllipse(pen, (w - r) / 2, (h - r) / 2, r, r);

            string simbolo = varon ? "♂" : "♀";
            using var f = new Font(FontFamily.GenericSansSerif, Math.Min(w, h) / 2.8f, FontStyle.Bold);
            var sz = g.MeasureString(simbolo, f);
            g.DrawString(simbolo, f, brush, (w - sz.Width) / 2, (h - sz.Height) / 2);

            return bmp;
        }

        private void PrepararImagenesDeBotones()
        {
            BGuardar.Image = SystemIcons.Information.ToBitmap();
            BEliminar.Image = SystemIcons.Warning.ToBitmap();
            BSalir.Image = SystemIcons.Error.ToBitmap();

            BGuardar.ImageAlign = ContentAlignment.MiddleLeft;
            BEliminar.ImageAlign = ContentAlignment.MiddleLeft;
            BSalir.ImageAlign = ContentAlignment.MiddleLeft;

            BGuardar.TextAlign = ContentAlignment.MiddleRight;
            BEliminar.TextAlign = ContentAlignment.MiddleRight;
            BSalir.TextAlign = ContentAlignment.MiddleRight;
        }
    }
}
