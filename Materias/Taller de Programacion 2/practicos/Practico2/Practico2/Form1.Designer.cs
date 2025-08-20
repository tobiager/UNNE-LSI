namespace Practico2
{
    partial class Form1
    {
        private System.ComponentModel.IContainer components = null;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            this.LDni = new System.Windows.Forms.Label();
            this.LNombre = new System.Windows.Forms.Label();
            this.LApellido = new System.Windows.Forms.Label();
            this.LNyA = new System.Windows.Forms.Label();
            this.LModificar = new System.Windows.Forms.Label();
            this.TDni = new System.Windows.Forms.TextBox();
            this.TNombre = new System.Windows.Forms.TextBox();
            this.TApellido = new System.Windows.Forms.TextBox();
            this.BGuardar = new System.Windows.Forms.Button();
            this.BEliminar = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // LDni
            // 
            this.LDni.AutoSize = true;
            this.LDni.Location = new System.Drawing.Point(24, 28);
            this.LDni.Name = "LDni";
            this.LDni.Size = new System.Drawing.Size(30, 15);
            this.LDni.TabIndex = 0;
            this.LDni.Text = "DNI";
            // 
            // LNombre
            // 
            this.LNombre.AutoSize = true;
            this.LNombre.Location = new System.Drawing.Point(24, 68);
            this.LNombre.Name = "LNombre";
            this.LNombre.Size = new System.Drawing.Size(54, 15);
            this.LNombre.TabIndex = 1;
            this.LNombre.Text = "Nombre";
            // 
            // LApellido
            // 
            this.LApellido.AutoSize = true;
            this.LApellido.Location = new System.Drawing.Point(24, 108);
            this.LApellido.Name = "LApellido";
            this.LApellido.Size = new System.Drawing.Size(51, 15);
            this.LApellido.TabIndex = 2;
            this.LApellido.Text = "Apellido";
            // 
            // LNyA
            // 
            this.LNyA.AutoSize = true;
            this.LNyA.Location = new System.Drawing.Point(24, 152);
            this.LNyA.Name = "LNyA";
            this.LNyA.Size = new System.Drawing.Size(112, 15);
            this.LNyA.TabIndex = 3;
            this.LNyA.Text = "Nombre y Apellido:";
            // 
            // LModificar
            // 
            this.LModificar.AutoSize = true;
            this.LModificar.ForeColor = System.Drawing.Color.Red;
            this.LModificar.Location = new System.Drawing.Point(24, 188);
            this.LModificar.Name = "LModificar";
            this.LModificar.Size = new System.Drawing.Size(64, 15);
            this.LModificar.TabIndex = 4;
            this.LModificar.Text = "Modificar";
            // 
            // TDni
            // 
            this.TDni.Location = new System.Drawing.Point(160, 25);
            this.TDni.Name = "TDni";
            this.TDni.Size = new System.Drawing.Size(200, 23);
            this.TDni.TabIndex = 5;
            this.TDni.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TDni_KeyPress);
            this.TDni.TextChanged += new System.EventHandler(this.ActualizarNyA);
            // 
            // TNombre
            // 
            this.TNombre.Location = new System.Drawing.Point(160, 65);
            this.TNombre.Name = "TNombre";
            this.TNombre.Size = new System.Drawing.Size(200, 23);
            this.TNombre.TabIndex = 6;
            this.TNombre.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.SoloLetras_KeyPress);
            this.TNombre.TextChanged += new System.EventHandler(this.ActualizarNyA);
            // 
            // TApellido
            // 
            this.TApellido.Location = new System.Drawing.Point(160, 105);
            this.TApellido.Name = "TApellido";
            this.TApellido.Size = new System.Drawing.Size(200, 23);
            this.TApellido.TabIndex = 7;
            this.TApellido.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.SoloLetras_KeyPress);
            this.TApellido.TextChanged += new System.EventHandler(this.ActualizarNyA);
            // 
            // BGuardar
            // 
            this.BGuardar.Location = new System.Drawing.Point(160, 228);
            this.BGuardar.Name = "BGuardar";
            this.BGuardar.Size = new System.Drawing.Size(94, 29);
            this.BGuardar.TabIndex = 8;
            this.BGuardar.Text = "Guardar";
            this.BGuardar.UseVisualStyleBackColor = true;
            this.BGuardar.Click += new System.EventHandler(this.BGuardar_Click);
            // 
            // BEliminar
            // 
            this.BEliminar.Location = new System.Drawing.Point(266, 228);
            this.BEliminar.Name = "BEliminar";
            this.BEliminar.Size = new System.Drawing.Size(94, 29);
            this.BEliminar.TabIndex = 9;
            this.BEliminar.Text = "Eliminar";
            this.BEliminar.UseVisualStyleBackColor = true;
            this.BEliminar.Click += new System.EventHandler(this.BEliminar_Click);
            // 
            // Form1
            // 
            this.ClientSize = new System.Drawing.Size(392, 279);
            this.Controls.Add(this.BEliminar);
            this.Controls.Add(this.BGuardar);
            this.Controls.Add(this.TApellido);
            this.Controls.Add(this.TNombre);
            this.Controls.Add(this.TDni);
            this.Controls.Add(this.LModificar);
            this.Controls.Add(this.LNyA);
            this.Controls.Add(this.LApellido);
            this.Controls.Add(this.LNombre);
            this.Controls.Add(this.LDni);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Pequeño Formulario";
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        private System.Windows.Forms.Label LDni;
        private System.Windows.Forms.Label LNombre;
        private System.Windows.Forms.Label LApellido;
        private System.Windows.Forms.Label LNyA;
        private System.Windows.Forms.Label LModificar;
        private System.Windows.Forms.TextBox TDni;
        private System.Windows.Forms.TextBox TNombre;
        private System.Windows.Forms.TextBox TApellido;
        private System.Windows.Forms.Button BGuardar;
        private System.Windows.Forms.Button BEliminar;
    }
}
