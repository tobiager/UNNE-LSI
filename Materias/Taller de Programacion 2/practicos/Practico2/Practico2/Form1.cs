using System;
using System.Windows.Forms;

namespace Practico2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            Text = "Pequeño Formulario";
        }

        private void TDni_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
                e.Handled = true;
        }

        private void SoloLetras_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsLetter(e.KeyChar) && e.KeyChar != ' ')
                e.Handled = true;
        }

        private void ActualizarNyA(object sender, EventArgs e)
        {
            LNyA.Text = $"Nombre y Apellido: {TNombre.Text} {TApellido.Text}".Trim();
        }

        private void BGuardar_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(TDni.Text) ||
                string.IsNullOrWhiteSpace(TNombre.Text) ||
                string.IsNullOrWhiteSpace(TApellido.Text))
            {
                MessageBox.Show("Debe completar todos los campos", "Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            DialogResult ask = MessageBox.Show(
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
                LModificar.ForeColor = System.Drawing.Color.Red;
            }
        }

        private void BEliminar_Click(object sender, EventArgs e)
        {
            string nya = $"{TNombre.Text} {TApellido.Text}".Trim();
            if (string.IsNullOrWhiteSpace(nya))
                nya = "(sin nombre)";

            DialogResult ask = MessageBox.Show(
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
                LNyA.Text = "Nombre y Apellido:";
                LModificar.Text = string.Empty;

                MessageBox.Show($"El Cliente: {nya} se eliminó correctamente", "Eliminar",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
    }
}
