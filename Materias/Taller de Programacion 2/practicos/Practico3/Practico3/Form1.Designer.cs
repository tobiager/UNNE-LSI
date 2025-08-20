namespace Practico3
{
    partial class Form1
    {
        private System.ComponentModel.IContainer? components = null;

        private System.Windows.Forms.Panel panelDatos = null!;
        private System.Windows.Forms.Label LDni = null!;
        private System.Windows.Forms.Label LNombre = null!;
        private System.Windows.Forms.Label LApellido = null!;
        private System.Windows.Forms.Label LCelular = null!;
        private System.Windows.Forms.TextBox TDni = null!;
        private System.Windows.Forms.TextBox TNombre = null!;
        private System.Windows.Forms.TextBox TApellido = null!;
        private System.Windows.Forms.TextBox TCelular = null!;

        private System.Windows.Forms.Label LNyA = null!;
        private System.Windows.Forms.Label LModificar = null!;

        private System.Windows.Forms.PictureBox PBIcono = null!;
        private System.Windows.Forms.RadioButton RBVaron = null!;
        private System.Windows.Forms.RadioButton RBMujer = null!;

        private System.Windows.Forms.CheckBox CBNaranja = null!;
        private System.Windows.Forms.CheckBox CBVisa = null!;
        private System.Windows.Forms.CheckBox CBMaster = null!;

        private System.Windows.Forms.Button BGuardar = null!;
        private System.Windows.Forms.Button BEliminar = null!;
        private System.Windows.Forms.Button BSalir = null!;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null)) components.Dispose();
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            panelDatos = new Panel();
            LCelular = new Label();
            TCelular = new TextBox();
            LDni = new Label();
            LNombre = new Label();
            LApellido = new Label();
            TDni = new TextBox();
            TNombre = new TextBox();
            TApellido = new TextBox();
            LNyA = new Label();
            LModificar = new Label();
            PBIcono = new PictureBox();
            RBVaron = new RadioButton();
            RBMujer = new RadioButton();
            CBNaranja = new CheckBox();
            CBVisa = new CheckBox();
            CBMaster = new CheckBox();
            BGuardar = new Button();
            BEliminar = new Button();
            BSalir = new Button();
            panelDatos.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)PBIcono).BeginInit();
            SuspendLayout();
            // 
            // panelDatos
            // 
            panelDatos.BackColor = Color.AliceBlue;
            panelDatos.BorderStyle = BorderStyle.FixedSingle;
            panelDatos.Controls.Add(LCelular);
            panelDatos.Controls.Add(TCelular);
            panelDatos.Controls.Add(LDni);
            panelDatos.Controls.Add(LNombre);
            panelDatos.Controls.Add(LApellido);
            panelDatos.Controls.Add(TDni);
            panelDatos.Controls.Add(TNombre);
            panelDatos.Controls.Add(TApellido);
            panelDatos.Location = new Point(20, 18);
            panelDatos.Name = "panelDatos";
            panelDatos.Size = new Size(360, 170);
            panelDatos.TabIndex = 11;
            // 
            // LCelular
            // 
            LCelular.AutoSize = true;
            LCelular.Location = new Point(12, 128);
            LCelular.Name = "LCelular";
            LCelular.Size = new Size(48, 15);
            LCelular.TabIndex = 0;
            LCelular.Text = "Celular";
            // 
            // TCelular
            // 
            TCelular.Location = new Point(100, 125);
            TCelular.Name = "TCelular";
            TCelular.Size = new Size(230, 23);
            TCelular.TabIndex = 1;
            TCelular.KeyPress += new KeyPressEventHandler(this.SoloNumeros_KeyPress);
            // 
            // LDni
            // 
            LDni.AutoSize = true;
            LDni.Location = new Point(12, 14);
            LDni.Name = "LDni";
            LDni.Size = new Size(27, 15);
            LDni.TabIndex = 2;
            LDni.Text = "DNI";
            // 
            // LNombre
            // 
            LNombre.AutoSize = true;
            LNombre.Location = new Point(12, 52);
            LNombre.Name = "LNombre";
            LNombre.Size = new Size(54, 15);
            LNombre.TabIndex = 3;
            LNombre.Text = "Nombre";
            // 
            // LApellido
            // 
            LApellido.AutoSize = true;
            LApellido.Location = new Point(12, 90);
            LApellido.Name = "LApellido";
            LApellido.Size = new Size(53, 15);
            LApellido.TabIndex = 4;
            LApellido.Text = "Apellido";
            // 
            // TDni
            // 
            TDni.Location = new Point(100, 11);
            TDni.Name = "TDni";
            TDni.Size = new Size(230, 23);
            TDni.TabIndex = 5;
            TDni.TextChanged += ActualizarNyA;
            TDni.KeyPress += TDni_KeyPress;
            // 
            // TNombre
            // 
            TNombre.Location = new Point(100, 49);
            TNombre.Name = "TNombre";
            TNombre.Size = new Size(230, 23);
            TNombre.TabIndex = 6;
            TNombre.TextChanged += ActualizarNyA;
            TNombre.KeyPress += SoloLetras_KeyPress;
            // 
            // TApellido
            // 
            TApellido.Location = new Point(100, 87);
            TApellido.Name = "TApellido";
            TApellido.Size = new Size(230, 23);
            TApellido.TabIndex = 7;
            TApellido.TextChanged += ActualizarNyA;
            TApellido.KeyPress += SoloLetras_KeyPress;
            // 
            // LNyA
            // 
            LNyA.AutoSize = true;
            LNyA.Location = new Point(20, 200);
            LNyA.Name = "LNyA";
            LNyA.Size = new Size(112, 15);
            LNyA.TabIndex = 10;
            LNyA.Text = "Nombre y Apellido:";
            // 
            // LModificar
            // 
            LModificar.AutoSize = true;
            LModificar.ForeColor = Color.Red;
            LModificar.Location = new Point(20, 225);
            LModificar.Name = "LModificar";
            LModificar.Size = new Size(0, 15);
            LModificar.TabIndex = 9;
            // 
            // PBIcono
            // 
            PBIcono.BackColor = Color.White;
            PBIcono.BorderStyle = BorderStyle.FixedSingle;
            PBIcono.Location = new Point(410, 18);
            PBIcono.Name = "PBIcono";
            PBIcono.Size = new Size(180, 170);
            PBIcono.SizeMode = PictureBoxSizeMode.CenterImage;
            PBIcono.TabIndex = 8;
            PBIcono.TabStop = false;
            // 
            // RBVaron
            // 
            RBVaron.AutoSize = true;
            RBVaron.Location = new Point(410, 198);
            RBVaron.Name = "RBVaron";
            RBVaron.Size = new Size(57, 19);
            RBVaron.TabIndex = 7;
            RBVaron.Text = "Varón";
            RBVaron.CheckedChanged += RBVaron_CheckedChanged;
            // 
            // RBMujer
            // 
            RBMujer.AutoSize = true;
            RBMujer.Location = new Point(480, 198);
            RBMujer.Name = "RBMujer";
            RBMujer.Size = new Size(56, 19);
            RBMujer.TabIndex = 6;
            RBMujer.Text = "Mujer";
            RBMujer.CheckedChanged += RBMujer_CheckedChanged;
            // 
            // CBNaranja
            // 
            CBNaranja.AutoSize = true;
            CBNaranja.Location = new Point(410, 225);
            CBNaranja.Name = "CBNaranja";
            CBNaranja.Size = new Size(70, 19);
            CBNaranja.TabIndex = 5;
            CBNaranja.Text = "Naranja";
            // 
            // CBVisa
            // 
            CBVisa.AutoSize = true;
            CBVisa.Location = new Point(490, 225);
            CBVisa.Name = "CBVisa";
            CBVisa.Size = new Size(46, 19);
            CBVisa.TabIndex = 4;
            CBVisa.Text = "Visa";
            // 
            // CBMaster
            // 
            CBMaster.AutoSize = true;
            CBMaster.Location = new Point(545, 225);
            CBMaster.Name = "CBMaster";
            CBMaster.Size = new Size(90, 19);
            CBMaster.TabIndex = 3;
            CBMaster.Text = "Mastercard";
            // 
            // BGuardar
            // 
            BGuardar.Location = new Point(20, 265);
            BGuardar.Name = "BGuardar";
            BGuardar.Size = new Size(110, 32);
            BGuardar.TabIndex = 2;
            BGuardar.Text = "Guardar";
            BGuardar.UseVisualStyleBackColor = true;
            BGuardar.Click += BGuardar_Click;
            // 
            // BEliminar
            // 
            BEliminar.Location = new Point(140, 265);
            BEliminar.Name = "BEliminar";
            BEliminar.Size = new Size(110, 32);
            BEliminar.TabIndex = 1;
            BEliminar.Text = "Eliminar";
            BEliminar.UseVisualStyleBackColor = true;
            BEliminar.Click += BEliminar_Click;
            // 
            // BSalir
            // 
            BSalir.Location = new Point(260, 265);
            BSalir.Name = "BSalir";
            BSalir.Size = new Size(110, 32);
            BSalir.TabIndex = 0;
            BSalir.Text = "Salir";
            BSalir.UseVisualStyleBackColor = true;
            BSalir.Click += BSalir_Click;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(680, 320);
            Controls.Add(BSalir);
            Controls.Add(BEliminar);
            Controls.Add(BGuardar);
            Controls.Add(CBMaster);
            Controls.Add(CBVisa);
            Controls.Add(CBNaranja);
            Controls.Add(RBMujer);
            Controls.Add(RBVaron);
            Controls.Add(PBIcono);
            Controls.Add(LModificar);
            Controls.Add(LNyA);
            Controls.Add(panelDatos);
            FormBorderStyle = FormBorderStyle.FixedDialog;
            MaximizeBox = false;
            Name = "Form1";
            StartPosition = FormStartPosition.CenterParent;
            Text = "Pequeño Formulario";
            panelDatos.ResumeLayout(false);
            panelDatos.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)PBIcono).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }
    }
}
