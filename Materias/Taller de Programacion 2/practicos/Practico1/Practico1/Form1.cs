using System;
using System.Windows.Forms;

namespace Practico1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            this.StartPosition = FormStartPosition.CenterScreen; // Centrar en pantalla
            this.KeyPreview = true; // Habilitar captura de teclas
            this.KeyDown += Form1_KeyDown; // Evento para Ctrl + S
        }

        // Botón Guardar → concatena Apellido + Nombre en el TextBox multilinea
        private void BGuardar_Click(object sender, EventArgs e)
        {
            textBox3.Text = textBox1.Text + " " + textBox2.Text;
        }

        // Botón Eliminar → limpia el TextBox multilinea
        private void BEliminar_Click(object sender, EventArgs e)
        {
            textBox3.Clear();
        }

        // Botón Salir → cierra la aplicación
        private void BSalir_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        // Atajo Ctrl + S → salir
        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Control && e.KeyCode == Keys.S)
            {
                Application.Exit();
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
