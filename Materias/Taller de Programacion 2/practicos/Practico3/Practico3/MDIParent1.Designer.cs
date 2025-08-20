using System.Windows.Forms;

namespace Practico3
{
    partial class MDIParent1
    {
        /// <summary>Required designer variable.</summary>
        private System.ComponentModel.IContainer? components = null;

        private MenuStrip menuStrip1 = null!;
        private ToolStripMenuItem menuArchivo = null!;
        private ToolStripMenuItem menuNuevoPequenoFormulario = null!;
        private ToolStripMenuItem menuSalir = null!;

        /// <summary>Clean up any resources being used.</summary>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
                components.Dispose();
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        private void InitializeComponent()
        {
            this.menuStrip1 = new MenuStrip();
            this.menuArchivo = new ToolStripMenuItem();
            this.menuNuevoPequenoFormulario = new ToolStripMenuItem();
            this.menuSalir = new ToolStripMenuItem();
            this.menuStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new ToolStripItem[] {
                this.menuArchivo
            });
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1000, 24);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // menuArchivo
            // 
            this.menuArchivo.DropDownItems.AddRange(new ToolStripItem[] {
                this.menuNuevoPequenoFormulario,
                this.menuSalir
            });
            this.menuArchivo.Name = "menuArchivo";
            this.menuArchivo.Size = new System.Drawing.Size(60, 20);
            this.menuArchivo.Text = "Archivo";
            // 
            // menuNuevoPequenoFormulario
            // 
            this.menuNuevoPequenoFormulario.Name = "menuNuevoPequenoFormulario";
            this.menuNuevoPequenoFormulario.Size = new System.Drawing.Size(226, 22);
            this.menuNuevoPequenoFormulario.Text = "Nuevo Pequeño Formulario";
            this.menuNuevoPequenoFormulario.Click += new System.EventHandler(this.menuNuevoPequenoFormulario_Click);
            // 
            // menuSalir
            // 
            this.menuSalir.Name = "menuSalir";
            this.menuSalir.Size = new System.Drawing.Size(226, 22);
            this.menuSalir.Text = "Salir";
            this.menuSalir.Click += new System.EventHandler(this.menuSalir_Click);
            // 
            // MDIParent1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1000, 650);
            this.Controls.Add(this.menuStrip1);
            this.IsMdiContainer = true;            // clave: contenedor MDI
            this.MainMenuStrip = this.menuStrip1;  // asocia el menú
            this.Name = "MDIParent1";
            this.StartPosition = FormStartPosition.CenterScreen;
            this.Text = "Pequeño Sistema";
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();
        }

        #endregion
    }
}
