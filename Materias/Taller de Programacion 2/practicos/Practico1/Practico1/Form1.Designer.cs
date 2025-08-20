using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;

namespace Practico1
{
    partial class Form1
    {
        private IContainer components = null;

        private Button BGuardar;
        private Button BEliminar;
        private Button BSalir;
        private Label LApellido;
        private Label LNombre;
        private TextBox textBox1; // Apellido
        private TextBox textBox2; // Nombre
        private TextBox textBox3; // Multilínea (resultado)

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code
        private void InitializeComponent()
        {
            BGuardar = new Button();
            BEliminar = new Button();
            BSalir = new Button();
            LApellido = new Label();
            LNombre = new Label();
            textBox1 = new TextBox();
            textBox2 = new TextBox();
            textBox3 = new TextBox();
            SuspendLayout();
            // 
            // BGuardar
            // 
            BGuardar.Location = new Point(24, 187);
            BGuardar.Name = "BGuardar";
            BGuardar.Size = new Size(110, 30);
            BGuardar.TabIndex = 5;
            BGuardar.Text = "Guardar";
            BGuardar.UseVisualStyleBackColor = true;
            BGuardar.Click += BGuardar_Click;
            // 
            // BEliminar
            // 
            BEliminar.Location = new Point(192, 187);
            BEliminar.Name = "BEliminar";
            BEliminar.Size = new Size(110, 30);
            BEliminar.TabIndex = 6;
            BEliminar.Text = "Eliminar";
            BEliminar.UseVisualStyleBackColor = true;
            BEliminar.Click += BEliminar_Click;
            // 
            // BSalir
            // 
            BSalir.Location = new Point(106, 252);
            BSalir.Name = "BSalir";
            BSalir.Size = new Size(110, 30);
            BSalir.TabIndex = 7;
            BSalir.Text = "Salir";
            BSalir.UseVisualStyleBackColor = true;
            BSalir.Click += BSalir_Click;
            // 
            // LApellido
            // 
            LApellido.AutoSize = true;
            LApellido.Location = new Point(24, 77);
            LApellido.Name = "LApellido";
            LApellido.Size = new Size(51, 15);
            LApellido.TabIndex = 0;
            LApellido.Text = "Apellido";
            // 
            // LNombre
            // 
            LNombre.AutoSize = true;
            LNombre.Location = new Point(24, 139);
            LNombre.Name = "LNombre";
            LNombre.Size = new Size(51, 15);
            LNombre.TabIndex = 2;
            LNombre.Text = "Nombre";
            // 
            // textBox1
            // 
            textBox1.Location = new Point(94, 74);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(220, 23);
            textBox1.TabIndex = 1;
            // 
            // textBox2
            // 
            textBox2.Location = new Point(94, 136);
            textBox2.Name = "textBox2";
            textBox2.Size = new Size(220, 23);
            textBox2.TabIndex = 3;
            // 
            // textBox3
            // 
            textBox3.Location = new Point(333, 77);
            textBox3.Multiline = true;
            textBox3.Name = "textBox3";
            textBox3.ScrollBars = ScrollBars.Vertical;
            textBox3.Size = new Size(296, 140);
            textBox3.TabIndex = 4;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(664, 403);
            Controls.Add(BGuardar);
            Controls.Add(BEliminar);
            Controls.Add(BSalir);
            Controls.Add(LApellido);
            Controls.Add(textBox1);
            Controls.Add(LNombre);
            Controls.Add(textBox2);
            Controls.Add(textBox3);
            KeyPreview = true;
            Name = "Form1";
            StartPosition = FormStartPosition.CenterScreen;
            Text = "Mi Primer Forms";
            Load += Form1_Load;
            KeyDown += Form1_KeyDown;
            ResumeLayout(false);
            PerformLayout();
        }
        #endregion
    }
}
