<?= $this->extend('layout') ?>
<?= $this->section('contenido') ?>
<div class="container py-5">
  <div class="bg-dark text-white p-4 rounded shadow">
    <h2 class="mb-4">💳 Paso 3: Método de Envío y Pago</h2>
    <form action="<?= base_url('checkout/guardarPago') ?>" method="post">
      <h5>Método de Envío</h5>
      <div class="form-check">
        <input class="form-check-input" type="radio" name="envio" value="estandar" id="envio1" checked>
        <label class="form-check-label" for="envio1">Envío Estándar - $1000</label>
      </div>
      <div class="form-check mb-4">
        <input class="form-check-input" type="radio" name="envio" value="express" id="envio2">
        <label class="form-check-label" for="envio2">Envío Express - $2500</label>
      </div>

      <h5>Datos de Tarjeta</h5>
      <div class="row g-3">
        <div class="col-12">
          <label class="form-label">Nombre en la Tarjeta</label>
          <input type="text" class="form-control" name="nombre_tarjeta" required>
        </div>
        <div class="col-12">
          <label class="form-label">Número de Tarjeta</label>
          <input type="text" class="form-control" name="numero_tarjeta" placeholder="1234 5678 9012 3456" required>
        </div>
        <div class="col-md-6">
          <label class="form-label">Vencimiento</label>
          <input type="text" class="form-control" name="vencimiento" placeholder="MM/AA" required>
        </div>
        <div class="col-md-6">
          <label class="form-label">CVV</label>
          <input type="text" class="form-control" name="cvv" placeholder="123" required>
        </div>
      </div>

      <div class="text-end mt-4">
        <button type="submit" class="btn btn-danger">Continuar a Revisión <i class="bi bi-arrow-right"></i></button>
      </div>
    </form>
  </div>
</div>
<?= $this->endSection() ?>