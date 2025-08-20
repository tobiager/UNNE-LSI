// Form1.Designer.cs
namespace Practico5
{
    partial class Form1
    {
        /// <summary>Required designer variable.</summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>Clean up any resources being used.</summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
                components.Dispose();
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>Required method for Designer support - do not modify
        /// the contents of this method with the code editor.</summary>
        private void InitializeComponent()
        {
            this.pnlHeader = new System.Windows.Forms.Panel();
            this.lblTitulo = new System.Windows.Forms.Label();

            this.lblNombre = new System.Windows.Forms.Label();
            this.txtNombre = new System.Windows.Forms.TextBox();

            this.lblApellido = new System.Windows.Forms.Label();
            this.txtApellido = new System.Windows.Forms.TextBox();

            this.lblSexo = new System.Windows.Forms.Label();
            this.rbM = new System.Windows.Forms.RadioButton();
            this.rbF = new System.Windows.Forms.RadioButton();
            this.rbX = new System.Windows.Forms.RadioButton();

            this.lblFecha = new System.Windows.Forms.Label();
            this.dtpFecha = new System.Windows.Forms.DateTimePicker();

            this.lblSaldo = new System.Windows.Forms.Label();
            this.txtSaldo = new System.Windows.Forms.TextBox();

            this.lblFoto = new System.Windows.Forms.Label();
            this.txtFoto = new System.Windows.Forms.TextBox();
            this.btnSeleccionarFoto = new System.Windows.Forms.Button();

            this.picFoto = new System.Windows.Forms.PictureBox();
            this.btnGuardar = new System.Windows.Forms.Button();

            this.dgvClientes = new System.Windows.Forms.DataGridView();
            this.colFoto = new System.Windows.Forms.DataGridViewImageColumn();
            this.colNombre = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colApellido = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colSexo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colFecha = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colSaldo = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.colEliminar = new System.Windows.Forms.DataGridViewButtonColumn();
            this.colRuta = new System.Windows.Forms.DataGridViewTextBoxColumn();

            ((System.ComponentModel.ISupportInitialize)(this.picFoto)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvClientes)).BeginInit();
            this.SuspendLayout();

            // ---------------- Header ----------------
            // pnlHeader
            this.pnlHeader.Location = new System.Drawing.Point(12, 12);
            this.pnlHeader.Name = "pnlHeader";
            this.pnlHeader.Size = new System.Drawing.Size(965, 70);
            this.pnlHeader.TabIndex = 0;

            // lblTitulo
            this.lblTitulo.AutoSize = false;
            this.lblTitulo.Location = new System.Drawing.Point(15, 20);
            this.lblTitulo.Name = "lblTitulo";
            this.lblTitulo.Size = new System.Drawing.Size(935, 35);
            this.lblTitulo.TabIndex = 1;
            this.lblTitulo.Text = "ABM de Clientes";
            this.lblTitulo.TextAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.pnlHeader.Controls.Add(this.lblTitulo);

            // ---------------- Entradas (izquierda) ----------------
            int x1 = 20, y1 = 110, dy = 40;

            // lblNombre
            this.lblNombre.AutoSize = true;
            this.lblNombre.Location = new System.Drawing.Point(x1, y1);
            this.lblNombre.Name = "lblNombre";
            this.lblNombre.Size = new System.Drawing.Size(60, 15);
            this.lblNombre.Text = "Nombre:";

            // txtNombre
            this.txtNombre.Location = new System.Drawing.Point(x1 + 90, y1 - 4);
            this.txtNombre.Name = "txtNombre";
            this.txtNombre.Size = new System.Drawing.Size(220, 23);

            // lblApellido
            this.lblApellido.AutoSize = true;
            this.lblApellido.Location = new System.Drawing.Point(x1, y1 + dy);
            this.lblApellido.Name = "lblApellido";
            this.lblApellido.Size = new System.Drawing.Size(57, 15);
            this.lblApellido.Text = "Apellido:";

            // txtApellido
            this.txtApellido.Location = new System.Drawing.Point(x1 + 90, y1 + dy - 4);
            this.txtApellido.Name = "txtApellido";
            this.txtApellido.Size = new System.Drawing.Size(220, 23);

            // lblSexo
            this.lblSexo.AutoSize = true;
            this.lblSexo.Location = new System.Drawing.Point(x1, y1 + dy * 2);
            this.lblSexo.Name = "lblSexo";
            this.lblSexo.Size = new System.Drawing.Size(35, 15);
            this.lblSexo.Text = "Sexo:";

            // rbM
            this.rbM.AutoSize = true;
            this.rbM.Location = new System.Drawing.Point(x1 + 90, y1 + dy * 2 - 3);
            this.rbM.Name = "rbM";
            this.rbM.Size = new System.Drawing.Size(80, 19);
            this.rbM.TabStop = true;
            this.rbM.Text = "Masculino";
            this.rbM.UseVisualStyleBackColor = true;

            // rbF
            this.rbF.AutoSize = true;
            this.rbF.Location = new System.Drawing.Point(x1 + 180, y1 + dy * 2 - 3);
            this.rbF.Name = "rbF";
            this.rbF.Size = new System.Drawing.Size(78, 19);
            this.rbF.Text = "Femenino";
            this.rbF.UseVisualStyleBackColor = true;

            // rbX
            this.rbX.AutoSize = true;
            this.rbX.Location = new System.Drawing.Point(x1 + 270, y1 + dy * 2 - 3);
            this.rbX.Name = "rbX";
            this.rbX.Size = new System.Drawing.Size(49, 19);
            this.rbX.Text = "Otro";
            this.rbX.UseVisualStyleBackColor = true;

            // lblFecha
            this.lblFecha.AutoSize = true;
            this.lblFecha.Location = new System.Drawing.Point(x1, y1 + dy * 3);
            this.lblFecha.Name = "lblFecha";
            this.lblFecha.Size = new System.Drawing.Size(42, 15);
            this.lblFecha.Text = "Fecha:";

            // dtpFecha
            this.dtpFecha.Location = new System.Drawing.Point(x1 + 90, y1 + dy * 3 - 5);
            this.dtpFecha.Name = "dtpFecha";
            this.dtpFecha.Size = new System.Drawing.Size(140, 23);
            this.dtpFecha.Format = System.Windows.Forms.DateTimePickerFormat.Short;

            // lblSaldo
            this.lblSaldo.AutoSize = true;
            this.lblSaldo.Location = new System.Drawing.Point(x1, y1 + dy * 4);
            this.lblSaldo.Name = "lblSaldo";
            this.lblSaldo.Size = new System.Drawing.Size(54, 15);
            this.lblSaldo.Text = "Saldo ($):";

            // txtSaldo
            this.txtSaldo.Location = new System.Drawing.Point(x1 + 90, y1 + dy * 4 - 4);
            this.txtSaldo.Name = "txtSaldo";
            this.txtSaldo.Size = new System.Drawing.Size(140, 23);

            // lblFoto
            this.lblFoto.AutoSize = true;
            this.lblFoto.Location = new System.Drawing.Point(x1, y1 + dy * 5);
            this.lblFoto.Name = "lblFoto";
            this.lblFoto.Size = new System.Drawing.Size(34, 15);
            this.lblFoto.Text = "Foto:";

            // txtFoto
            this.txtFoto.Location = new System.Drawing.Point(x1 + 90, y1 + dy * 5 - 4);
            this.txtFoto.Name = "txtFoto";
            this.txtFoto.ReadOnly = true;
            this.txtFoto.Size = new System.Drawing.Size(220, 23);

            // btnSeleccionarFoto
            this.btnSeleccionarFoto.Location = new System.Drawing.Point(x1 + 320, y1 + dy * 5 - 6);
            this.btnSeleccionarFoto.Name = "btnSeleccionarFoto";
            this.btnSeleccionarFoto.Size = new System.Drawing.Size(120, 27);
            this.btnSeleccionarFoto.Text = "Seleccionar...";
            this.btnSeleccionarFoto.UseVisualStyleBackColor = true;

            // ---------------- Imagen y Guardar (derecha) ----------------
            // picFoto
            this.picFoto.Location = new System.Drawing.Point(460, 106);
            this.picFoto.Name = "picFoto";
            this.picFoto.Size = new System.Drawing.Size(180, 180);
            this.picFoto.TabStop = false;
            this.picFoto.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.picFoto.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.picFoto.BackColor = System.Drawing.Color.White;

            // btnGuardar
            this.btnGuardar.Location = new System.Drawing.Point(460, 296);
            this.btnGuardar.Name = "btnGuardar";
            this.btnGuardar.Size = new System.Drawing.Size(180, 40);
            this.btnGuardar.Text = " Guardar";
            this.btnGuardar.UseVisualStyleBackColor = true;
            this.btnGuardar.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            this.btnGuardar.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;

            // ---------------- DataGridView ----------------
            this.dgvClientes.AllowUserToAddRows = false;
            this.dgvClientes.ReadOnly = true;
            this.dgvClientes.RowHeadersVisible = false;
            this.dgvClientes.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dgvClientes.MultiSelect = false;
            this.dgvClientes.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dgvClientes.Location = new System.Drawing.Point(20, 360);
            this.dgvClientes.Name = "dgvClientes";
            this.dgvClientes.Size = new System.Drawing.Size(960, 250);
            this.dgvClientes.RowTemplate.Height = 80;

            // columnas
            this.colFoto.HeaderText = "Foto";
            this.colFoto.Name = "colFoto";
            this.colFoto.ImageLayout = System.Windows.Forms.DataGridViewImageCellLayout.Stretch;

            this.colNombre.HeaderText = "Nombre";
            this.colNombre.Name = "colNombre";

            this.colApellido.HeaderText = "Apellido";
            this.colApellido.Name = "colApellido";

            this.colSexo.HeaderText = "Sexo";
            this.colSexo.Name = "colSexo";

            this.colFecha.HeaderText = "Fecha";
            this.colFecha.Name = "colFecha";

            this.colSaldo.HeaderText = "Saldo ($)";
            this.colSaldo.Name = "colSaldo";

            this.colEliminar.HeaderText = "Acción";
            this.colEliminar.Name = "colEliminar";
            this.colEliminar.Text = "Eliminar";
            this.colEliminar.UseColumnTextForButtonValue = true;

            this.colRuta.HeaderText = "Ruta";
            this.colRuta.Name = "colRuta";
            this.colRuta.Visible = false; // oculto por defecto

            this.dgvClientes.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
                this.colFoto, this.colNombre, this.colApellido, this.colSexo,
                this.colFecha, this.colSaldo, this.colEliminar, this.colRuta
            });

            // ---------------- Form ----------------
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1000, 640);
            this.Controls.Add(this.pnlHeader);

            this.Controls.Add(this.lblNombre);
            this.Controls.Add(this.txtNombre);
            this.Controls.Add(this.lblApellido);
            this.Controls.Add(this.txtApellido);
            this.Controls.Add(this.lblSexo);
            this.Controls.Add(this.rbM);
            this.Controls.Add(this.rbF);
            this.Controls.Add(this.rbX);
            this.Controls.Add(this.lblFecha);
            this.Controls.Add(this.dtpFecha);
            this.Controls.Add(this.lblSaldo);
            this.Controls.Add(this.txtSaldo);
            this.Controls.Add(this.lblFoto);
            this.Controls.Add(this.txtFoto);
            this.Controls.Add(this.btnSeleccionarFoto);

            this.Controls.Add(this.picFoto);
            this.Controls.Add(this.btnGuardar);

            this.Controls.Add(this.dgvClientes);

            this.Name = "Form1";
            this.Text = "Formulario con Grid";

            ((System.ComponentModel.ISupportInitialize)(this.picFoto)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgvClientes)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        #endregion

        private System.Windows.Forms.Panel pnlHeader;
        private System.Windows.Forms.Label lblTitulo;

        private System.Windows.Forms.Label lblNombre;
        private System.Windows.Forms.TextBox txtNombre;

        private System.Windows.Forms.Label lblApellido;
        private System.Windows.Forms.TextBox txtApellido;

        private System.Windows.Forms.Label lblSexo;
        private System.Windows.Forms.RadioButton rbM;
        private System.Windows.Forms.RadioButton rbF;
        private System.Windows.Forms.RadioButton rbX;

        private System.Windows.Forms.Label lblFecha;
        private System.Windows.Forms.DateTimePicker dtpFecha;

        private System.Windows.Forms.Label lblSaldo;
        private System.Windows.Forms.TextBox txtSaldo;

        private System.Windows.Forms.Label lblFoto;
        private System.Windows.Forms.TextBox txtFoto;
        private System.Windows.Forms.Button btnSeleccionarFoto;

        private System.Windows.Forms.PictureBox picFoto;
        private System.Windows.Forms.Button btnGuardar;

        private System.Windows.Forms.DataGridView dgvClientes;
        private System.Windows.Forms.DataGridViewImageColumn colFoto;
        private System.Windows.Forms.DataGridViewTextBoxColumn colNombre;
        private System.Windows.Forms.DataGridViewTextBoxColumn colApellido;
        private System.Windows.Forms.DataGridViewTextBoxColumn colSexo;
        private System.Windows.Forms.DataGridViewTextBoxColumn colFecha;
        private System.Windows.Forms.DataGridViewTextBoxColumn colSaldo;
        private System.Windows.Forms.DataGridViewButtonColumn colEliminar;
        private System.Windows.Forms.DataGridViewTextBoxColumn colRuta;
    }
}
