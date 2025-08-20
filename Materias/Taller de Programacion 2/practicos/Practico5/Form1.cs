using System;
using System.IO;
using System.Windows.Forms;
using SD = System.Drawing; // alias para System.Drawing

namespace Practico5
{
    public partial class Form1 : Form
    {
        private readonly string assetsDir = Path.Combine(AppContext.BaseDirectory, "Assets");
        private readonly string fotosDir = Path.Combine(AppContext.BaseDirectory, "Fotos");
        private OpenFileDialog ofd;

        public Form1()
        {
            InitializeComponent();
            SetupStyles(); // estilos seguros (sin mover layout)

            // Ajustes generales
            this.StartPosition = FormStartPosition.CenterScreen;

            // Fuente base uniforme para inputs/labels
            var ui = new SD.Font("Segoe UI", 10F);
            this.Font = ui;
            lblNombre.Font = lblApellido.Font = lblSexo.Font = lblFecha.Font = lblSaldo.Font = ui;
            txtNombre.Font = txtApellido.Font = txtSaldo.Font = ui;
            rbM.Font = rbF.Font = rbX.Font = ui;
            dtpFecha.Font = ui;

            // DateTimePicker en formato corto (pedido)
            dtpFecha.Format = DateTimePickerFormat.Short;

            // Fuentes distintas SOLO en columnas del grid (punto del práctico)
            colNombre.DefaultCellStyle.Font = TryFont("Monotype Corsiva", 13, SD.FontStyle.Italic);
            colApellido.DefaultCellStyle.Font = TryFont("Papyrus", 12, SD.FontStyle.Regular);
            dgvClientes.RowTemplate.Height = 80;

            // Fondos (si existen en Assets) — no rompen el diseñador
            TrySetBackgroundImage(this, Path.Combine(assetsDir, "cuadros_negros-734708.png"), ImageLayout.Stretch);
            TrySetBackgroundImage(pnlHeader, Path.Combine(assetsDir, "images.jpg"), ImageLayout.Stretch);

            // Fallbacks si faltan assets
            if (this.BackgroundImage == null)
                this.BackColor = SD.Color.Gainsboro;
            if (pnlHeader.BackgroundImage == null)
                pnlHeader.BackColor = SD.Color.FromArgb(52, 58, 64);

            // Título
            lblTitulo.Text = "ABM de Clientes";
            lblTitulo.ForeColor = SD.Color.White;
            lblTitulo.Font = TryFont("Papyrus", 16, SD.FontStyle.Bold);
            lblTitulo.BackColor = SD.Color.Transparent;

            // Franja semitransparente bajo el título si hay imagen (puro dibujo, no cambia layout)
            pnlHeader.Paint += PnlHeader_Paint;

            // Icono del botón Guardar (escalado + padding)
            TrySetButtonImage(btnGuardar, Path.Combine(assetsDir, "floppy.png"));
            btnGuardar.ImageAlign = SD.ContentAlignment.MiddleLeft;
            btnGuardar.TextAlign = SD.ContentAlignment.MiddleRight;
            btnGuardar.Padding = new Padding(6, 0, 6, 0);

            // Carpeta de fotos para copias
            Directory.CreateDirectory(fotosDir);

            // Avatar por defecto al iniciar
            var avatar = Path.Combine(assetsDir, "avatar.jpg");
            if (File.Exists(avatar)) CargarImagenEnPictureBox(avatar); else picFoto.BackColor = SD.Color.White;

            // OpenFileDialog (filtro de imágenes)
            ofd = new OpenFileDialog { Filter = "Archivos de imagen|*.jpg;*.jpeg;*.png;*.bmp" };

            // Eventos
            btnSeleccionarFoto.Click += (s, e) => { if (ofd.ShowDialog() == DialogResult.OK) SeleccionarFoto(ofd.FileName); };
            txtNombre.Leave += (s, e) => txtNombre.Text = ToNombrePropio(txtNombre.Text);
            txtApellido.Leave += (s, e) => txtApellido.Text = ToNombrePropio(txtApellido.Text);
            btnGuardar.Click += BtnGuardar_Click;
            dgvClientes.CellContentClick += DgvClientes_CellContentClick;   // botón Eliminar
            dgvClientes.SelectionChanged += DgvClientes_SelectionChanged;    // sync sexo/foto

            // Defaults
            txtSaldo.Text = "0";
            rbM.Checked = true;
            this.AcceptButton = btnGuardar; // Enter guarda
        }

        // --------- Estilos seguros (no mueven nada del diseñador) ----------
        private void SetupStyles()
        {
            // Header
            lblTitulo.AutoSize = false;
            lblTitulo.Dock = DockStyle.Fill;
            lblTitulo.TextAlign = SD.ContentAlignment.MiddleLeft;
            lblTitulo.Padding = new Padding(16, 0, 0, 0);

            // PictureBox
            picFoto.BackColor = SD.Color.White;
            picFoto.SizeMode = PictureBoxSizeMode.Zoom;

            // DataGridView look claro (sin tocar Location/Size/Anchor)
            dgvClientes.EnableHeadersVisualStyles = false;
            dgvClientes.BackgroundColor = SD.Color.White;
            dgvClientes.BorderStyle = BorderStyle.None;
            dgvClientes.CellBorderStyle = DataGridViewCellBorderStyle.SingleHorizontal;
            dgvClientes.ColumnHeadersBorderStyle = DataGridViewHeaderBorderStyle.Single;
            dgvClientes.ColumnHeadersDefaultCellStyle.BackColor = SD.Color.FromArgb(245, 245, 245);
            dgvClientes.ColumnHeadersDefaultCellStyle.ForeColor = SD.Color.Black;
            dgvClientes.ColumnHeadersDefaultCellStyle.Font = new SD.Font("Segoe UI", 10, SD.FontStyle.Bold);
            dgvClientes.DefaultCellStyle.Font = new SD.Font("Segoe UI", 10);
            dgvClientes.AlternatingRowsDefaultCellStyle.BackColor = SD.Color.FromArgb(250, 250, 250);

            // Pesos de columnas (AutoSizeColumnsMode = Fill en el diseñador)
            colFoto.FillWeight = 12;
            colNombre.FillWeight = 18;
            colApellido.FillWeight = 18;
            colSexo.FillWeight = 10;
            colFecha.FillWeight = 12;
            colSaldo.FillWeight = 12;
            colEliminar.FillWeight = 10;
            colRuta.FillWeight = 8;
            colRuta.Visible = false;
        }

        // Franja semitransparente bajo el título (mejora la legibilidad sin tocar layout)
        private void PnlHeader_Paint(object? sender, PaintEventArgs e)
        {
            if (pnlHeader.BackgroundImage == null) return;
            var g = e.Graphics;
            var rect = new SD.Rectangle(10, pnlHeader.Height / 2 - 18, pnlHeader.Width - 20, 36);
            using var br = new SD.SolidBrush(SD.Color.FromArgb(140, 255, 255, 255)); // blanco 55% opacidad
            g.FillRectangle(br, rect);
        }

        // === Lógica de UI ===

        private void SeleccionarFoto(string rutaOrigen)
        {
            try
            {
                var file = Path.GetFileName(rutaOrigen);
                var destino = Path.Combine(fotosDir, file);
                File.Copy(rutaOrigen, destino, overwrite: true);

                txtFoto.Text = destino;
                CargarImagenEnPictureBox(destino);
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se pudo copiar/abrir la imagen.\n" + ex.Message, "Foto",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }
        }

        private void BtnGuardar_Click(object? sender, EventArgs e)
        {
            // Validaciones básicas
            if (string.IsNullOrWhiteSpace(txtNombre.Text) || string.IsNullOrWhiteSpace(txtApellido.Text))
            {
                MessageBox.Show("Completá Nombre y Apellido.", "Validación",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }
            if (!decimal.TryParse(txtSaldo.Text.Replace(',', '.'),
                System.Globalization.NumberStyles.Any,
                System.Globalization.CultureInfo.InvariantCulture, out decimal saldo))
            {
                MessageBox.Show("Saldo inválido.", "Validación",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            // Normalizo
            var nom = ToNombrePropio(txtNombre.Text);
            var ape = ToNombrePropio(txtApellido.Text);

            // Sexo
            string sexo = rbM.Checked ? rbM.Text : rbF.Checked ? rbF.Text : rbX.Text;

            // Ruta imagen (si no hay, avatar por defecto)
            string ruta = txtFoto.Text;
            var avatar = Path.Combine(assetsDir, "avatar.jpg");
            if (string.IsNullOrWhiteSpace(ruta) || !File.Exists(ruta)) ruta = avatar;

            var img = TryLoadImage(ruta);

            // Agrego fila
            int idx = dgvClientes.Rows.Add(img, nom, ape, sexo, dtpFecha.Value.ToShortDateString(),
                                           saldo.ToString("0.##"), "Eliminar", ruta);

            // Coloreo si saldo < 50
            if (saldo < 50m)
                dgvClientes.Rows[idx].DefaultCellStyle.BackColor = SD.Color.MistyRose;

            // Mostrar foto y limpiar
            CargarImagenEnPictureBox(ruta);
            txtFoto.Text = ruta;
            txtNombre.Clear();
            txtApellido.Clear();
            txtSaldo.Text = "0";
            rbM.Checked = true;
            dtpFecha.Value = DateTime.Today;
            txtNombre.Focus();
        }

        private void DgvClientes_CellContentClick(object? sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex < 0) return;
            if (dgvClientes.Columns[e.ColumnIndex].Name != "colEliminar") return;

            var r = MessageBox.Show("¿Eliminar este registro?", "Confirmar",
                MessageBoxButtons.YesNo, MessageBoxIcon.Question);

            if (r == DialogResult.Yes)
                dgvClientes.Rows.RemoveAt(e.RowIndex);
        }

        private void DgvClientes_SelectionChanged(object? sender, EventArgs e)
        {
            if (dgvClientes.CurrentRow == null) return;

            string sexo = Convert.ToString(dgvClientes.CurrentRow.Cells["colSexo"].Value) ?? "";
            rbM.Checked = sexo.Equals(rbM.Text, StringComparison.OrdinalIgnoreCase);
            rbF.Checked = sexo.Equals(rbF.Text, StringComparison.OrdinalIgnoreCase);
            rbX.Checked = sexo.Equals(rbX.Text, StringComparison.OrdinalIgnoreCase);

            string ruta = Convert.ToString(dgvClientes.CurrentRow.Cells["colRuta"].Value) ?? "";
            if (File.Exists(ruta))
            {
                txtFoto.Text = ruta;
                CargarImagenEnPictureBox(ruta);
            }
        }

        // === Helpers ===

        private static string ToNombrePropio(string? s)
        {
            s = (s ?? "").Trim();
            if (s.Length == 0) return "";
            return char.ToUpper(s[0]) + (s.Length > 1 ? s.Substring(1).ToLower() : "");
        }

        private void CargarImagenEnPictureBox(string ruta)
        {
            try
            {
                picFoto.Image?.Dispose();
                using var fs = new FileStream(ruta, FileMode.Open, FileAccess.Read);
                picFoto.Image = SD.Image.FromStream(fs);
            }
            catch { /* ignoro errores de lectura de imagen */ }
        }

        private static SD.Font TryFont(string family, float size, SD.FontStyle style)
        {
            try { return new SD.Font(family, size, style); }
            catch { return new SD.Font("Segoe UI", size, style); }
        }

        private static SD.Image? TryLoadImage(string path)
        {
            try
            {
                using var fs = new FileStream(path, FileMode.Open, FileAccess.Read);
                return SD.Image.FromStream(fs);
            }
            catch { return null; }
        }

        // OJO: ImageLayout es de Windows.Forms (no de System.Drawing)
        private static void TrySetBackgroundImage(Control c, string path, ImageLayout layout)
        {
            try
            {
                if (File.Exists(path))
                {
                    c.BackgroundImage = SD.Image.FromFile(path);
                    c.BackgroundImageLayout = layout;
                }
            }
            catch { }
        }

        // Ícono del botón Guardar escalado
        private static void TrySetButtonImage(Button b, string path)
        {
            try
            {
                if (!File.Exists(path)) return;
                using var src = SD.Image.FromFile(path);
                var scaled = new SD.Bitmap(src, new SD.Size(20, 20)); // ajustá si querés
                b.Image = scaled; // no dispose de scaled: lo usa el botón
            }
            catch { }
        }
    }
}
