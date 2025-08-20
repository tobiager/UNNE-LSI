<?= $this->extend('layout') ?>
<?= $this->section('contenido') ?>
<div class="container py-5">
  <h2 class="mb-4 text-white">📋 Paso 4: Revisión del Pedido</h2>
  <div class="row g-4">
    <div class="col-lg-8">
      <div class="card shadow-sm">
        <div class="card-header bg-danger text-white fw-bold">Productos en tu Carrito</div>
        <div class="card-body p-0">
          <table class="table mb-0">
            <thead class="table-light">
              <tr>
                <th>Producto</th>
                <th class="text-center">Cantidad</th>
                <th class="text-end">Precio</th>
              </tr>
            </thead>
            <tbody>
              <?php foreach ($productos as $p): ?>
              <tr>
                <td><?= esc($p['name']) ?></td>
                <td class="text-center"><?= $p['cantidad'] ?></td>
                <td class="text-end">$<?= number_format($p['price'], 2, ',', '.') ?></td>
              </tr>
              <?php endforeach; ?>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <div class="col-lg-4">
      <div class="card shadow-sm">
        <div class="card-header bg-light fw-bold">Resumen de Costos</div>
        <div class="card-body">
          <ul class="list-group list-group-flush">
            <li class="list-group-item d-flex justify-content-between">
              <span>Subtotal</span><span>$<?= number_format($subtotal, 2, ',', '.') ?></span>
            </li>
            <li class="list-group-item d-flex justify-content-between">
              <span>Envío</span><span>$<?= number_format($costoEnvio, 2, ',', '.') ?></span>
            </li>
            <li class="list-group-item d-flex justify-content-between">
              <span>Impuestos</span><span>$<?= number_format($impuestos, 2, ',', '.') ?></span>
            </li>
            <li class="list-group-item d-flex justify-content-between fw-bold text-danger">
              <span>Total</span><span>$<?= number_format($total, 2, ',', '.') ?></span>
            </li>
          </ul>
          <form action="<?= base_url('checkout/confirmarPedido') ?>" method="post" class="mt-4">
            <button type="submit" class="btn btn-success w-100">
              <i class="bi bi-check-circle"></i> Confirmar Pedido
            </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
<?= $this->endSection() ?>