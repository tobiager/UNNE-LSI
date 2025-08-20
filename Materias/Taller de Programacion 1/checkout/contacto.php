<?= $this->extend('layout') ?>
<?= $this->section('contenido') ?>
<div class="container py-5">
  <div class="bg-dark text-white p-4 rounded shadow">
    <h2 class="mb-4">📨 Paso 1: Información de Contacto</h2>
    <form action="<?= base_url('checkout/guardarContacto') ?>" method="post">
      <div class="mb-3">
        <label for="email" class="form-label">Correo Electrónico</label>
        <input type="email" class="form-control" name="email" required>
      </div>
      <div class="mb-3">
        <label for="telefono" class="form-label">Teléfono</label>
        <input type="text" class="form-control" name="telefono" required>
      </div>
      <div class="text-end">
        <button type="submit" class="btn btn-danger">Continuar a Dirección <i class="bi bi-arrow-right"></i></button>
      </div>
    </form>
  </div>
</div>
<?= $this->endSection() ?>