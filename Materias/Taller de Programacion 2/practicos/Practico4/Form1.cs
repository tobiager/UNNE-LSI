using System;
using System.Windows.Forms;

// Alias para evitar conflictos con ScottPlot
using SD = System.Drawing;
using WinLabel = System.Windows.Forms.Label;

using ScottPlot.WinForms;   // Solo el control FormsPlot (evita choques de tipos)

namespace Practico4
{
    public partial class Form1 : Form
    {
        // Título
        private WinLabel lblTitulo;

        // Entrada y acciones (columna izquierda)
        private WinLabel lblDesde;
        private TextBox txtDesde;
        private WinLabel lblHasta;
        private TextBox txtHasta;

        private Button btnGenerarFuncion;
        private Button btnPares;
        private Button btnImpares;
        private Button btnPrimos;

        private ListBox listNumeros;

        // Gráfico (ocupa el lugar del panel derecho del PDF)
        private FormsPlot grafico;

        // Ej4 (3 CheckBox + 2 Botones) -> ocultos para que quede igual a la imagen
        private CheckBox chkNegrita, chkCursiva, chkSubrayado;
        private Button btnAplicarEstilos, btnResetEstilos;

        public Form1()
        {
            Text = "Práctico 4 - WinForms (.NET)";
            StartPosition = FormStartPosition.CenterScreen;
            Font = new SD.Font("Segoe UI", 10);
            Width = 900;
            Height = 550;

            InicializarUI();
            WireEvents();
        }

        private void InicializarUI()
        {
            // --- Título arriba ---
            lblTitulo = new WinLabel
            {
                Text = "Lista de Números",
                Font = new SD.Font("Segoe UI", 12, SD.FontStyle.Bold),
                AutoSize = false,
                TextAlign = SD.ContentAlignment.MiddleCenter,
                Location = new SD.Point(20, 10),
                Size = new SD.Size(840, 30)
            };

            // --- Columna izquierda ---
            int xLeft = 40;
            int yBase = 60;

            lblDesde = new WinLabel { Text = "Desde", Location = new SD.Point(xLeft, yBase), AutoSize = true };
            txtDesde = new TextBox { Location = new SD.Point(xLeft + 60, yBase - 4), Width = 80 };

            lblHasta = new WinLabel { Text = "Hasta", Location = new SD.Point(xLeft, yBase + 34), AutoSize = true };
            txtHasta = new TextBox { Location = new SD.Point(xLeft + 60, yBase + 30), Width = 80 };

            btnGenerarFuncion = new Button
            {
                Text = "Generar Función",
                Location = new SD.Point(xLeft, yBase + 70),
                Width = 140
            };

            btnPares = new Button
            {
                Text = "Números Pares",
                Location = new SD.Point(xLeft, yBase + 110),
                Width = 140
            };
            btnImpares = new Button
            {
                Text = "Números Impares",
                Location = new SD.Point(xLeft, yBase + 150),
                Width = 140
            };
            btnPrimos = new Button
            {
                Text = "Números Primos",
                Location = new SD.Point(xLeft, yBase + 190),
                Width = 140
            };

            listNumeros = new ListBox
            {
                Location = new SD.Point(xLeft + 160, yBase - 4),
                Size = new SD.Size(220, 360)
            };

            // --- Gráfico a la derecha ---
            grafico = new FormsPlot
            {
                Location = new SD.Point(420, yBase - 4),
                Size = new SD.Size(420, 360)
            };

            // --- Ej4: 3 CheckBox + 2 Botones (ocultos para igualar la imagen) ---
            chkNegrita = new CheckBox { Text = "Negrita", Location = new SD.Point(420, yBase + 370), Visible = false };
            chkCursiva = new CheckBox { Text = "Cursiva", Location = new SD.Point(495, yBase + 370), Visible = false };
            chkSubrayado = new CheckBox { Text = "Subrayado", Location = new SD.Point(570, yBase + 370), Visible = false };

            btnAplicarEstilos = new Button { Text = "Aplicar estilos", Location = new SD.Point(420, yBase + 400), Width = 120, Visible = false };
            btnResetEstilos = new Button { Text = "Reset estilos", Location = new SD.Point(550, yBase + 400), Width = 120, Visible = false };

            Controls.Add(lblTitulo);

            Controls.Add(lblDesde);
            Controls.Add(txtDesde);
            Controls.Add(lblHasta);
            Controls.Add(txtHasta);

            Controls.Add(btnGenerarFuncion);
            Controls.Add(btnPares);
            Controls.Add(btnImpares);
            Controls.Add(btnPrimos);

            Controls.Add(listNumeros);
            Controls.Add(grafico);

            Controls.Add(chkNegrita);
            Controls.Add(chkCursiva);
            Controls.Add(chkSubrayado);
            Controls.Add(btnAplicarEstilos);
            Controls.Add(btnResetEstilos);

            // Enter = Generar
            this.AcceptButton = btnGenerarFuncion;
        }

        private void WireEvents()
        {
            btnGenerarFuncion.Click += (s, e) => { GenerarRango(); Graficar(); };
            btnPares.Click += (s, e) => { GenerarFiltrado(TipoFiltro.Pares); Graficar(); };
            btnImpares.Click += (s, e) => { GenerarFiltrado(TipoFiltro.Impares); Graficar(); };
            btnPrimos.Click += (s, e) => { GenerarFiltrado(TipoFiltro.Primos); Graficar(); };

            btnAplicarEstilos.Click += (s, e) => AplicarEstilosGrafico();
            btnResetEstilos.Click += (s, e) => ResetEstilosGrafico();
        }

        private enum TipoFiltro { Pares, Impares, Primos }

        // --- Lógica ---
        private void GenerarRango()
        {
            if (!ValidarEntrada(out int desde, out int hasta)) return;
            listNumeros.Items.Clear();
            for (int i = desde; i <= hasta; i++)
                listNumeros.Items.Add(i);
        }

        private void GenerarFiltrado(TipoFiltro filtro)
        {
            if (!ValidarEntrada(out int desde, out int hasta)) return;
            listNumeros.Items.Clear();

            for (int i = desde; i <= hasta; i++)
            {
                switch (filtro)
                {
                    case TipoFiltro.Pares:
                        if (i % 2 == 0) listNumeros.Items.Add(i);
                        break;
                    case TipoFiltro.Impares:
                        if (i % 2 != 0) listNumeros.Items.Add(i);
                        break;
                    case TipoFiltro.Primos:
                        if (EsPrimo(i)) listNumeros.Items.Add(i);
                        break;
                }
            }
        }

        private bool ValidarEntrada(out int desde, out int hasta)
        {
            desde = 0; hasta = 0;

            var sDesde = (txtDesde.Text ?? string.Empty).Trim();
            var sHasta = (txtHasta.Text ?? string.Empty).Trim();

            if (!int.TryParse(sDesde, out desde) || !int.TryParse(sHasta, out hasta))
            {
                MessageBox.Show("Ingrese enteros válidos en 'Desde' y 'Hasta'.", "Validación",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            if (desde > hasta)
            {
                MessageBox.Show("'Desde' no puede ser mayor que 'Hasta'.", "Validación",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return false;
            }
            return true;
        }

        private static bool EsPrimo(int n)
        {
            if (n < 2) return false;
            if (n == 2) return true;
            if (n % 2 == 0) return false;
            int lim = (int)Math.Sqrt(n);
            for (int d = 3; d <= lim; d += 2)
                if (n % d == 0) return false;
            return true;
        }

        // --- Gráfico ScottPlot v5 ---
        private void Graficar()
        {
            int count = listNumeros.Items.Count;
            double[] valores = new double[count];
            double[] indices = new double[count];

            for (int i = 0; i < count; i++)
            {
                valores[i] = Convert.ToDouble(listNumeros.Items[i]);
                indices[i] = i + 1; // índice 1..N
            }

            grafico.Plot.Clear();

            // v5: Scatter (línea/puntos). Si querés barras, puedo pasarte un snippet extra.
            grafico.Plot.Add.Scatter(indices, valores);

            grafico.Refresh();
        }

        // Punto 4 (si activás los controles de estilos) – ahora actúan sobre el gráfico
        private void AplicarEstilosGrafico()
        {
            // placeholder simple (se puede extender)
            grafico.Refresh();
        }

        private void ResetEstilosGrafico()
        {
            chkNegrita.Checked = chkCursiva.Checked = chkSubrayado.Checked = false;
            grafico.Refresh();
        }
    }
}
