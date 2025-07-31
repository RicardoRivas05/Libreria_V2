<div class="admin-container">
    <div class="admin-header">
        <h1>Gestión de Transacciones</h1>
        <div class="admin-stats">
            <div class="stat-card">
                <span class="stat-number">{{estadisticas.totalTransacciones}}</span>
                <span class="stat-label">Total Transacciones</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">{{estadisticas.transaccionesCompletadas}}</span>
                <span class="stat-label">Completadas</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">{{estadisticas.transaccionesPendientes}}</span>
                <span class="stat-label">Pendientes</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">L. {{estadisticas.promedioVenta}}</span>
                <span class="stat-label">Promedio Venta</span>
            </div>
        </div>
    </div>

    <div class="filtros-section">
        <form class="filtros-form" method="GET">
            <div class="filtro-group">
                <label for="fechaInicio">Fecha Inicio:</label>
                <input type="date" id="fechaInicio" name="fechaInicio" value="{{filtros.fechaInicio}}">
            </div>
            <div class="filtro-group">
                <label for="fechaFin">Fecha Fin:</label>
                <input type="date" id="fechaFin" name="fechaFin" value="{{filtros.fechaFin}}">
            </div>
            <div class="filtro-group">
                <label for="estado">Estado:</label>
                <select id="estado" name="estado">
                    <option value="">Todos</option>
                    <option value="completada" {{if filtros.estado == 'completada'}}selected{{endif filtros.estado == 'completada'}}>Completada</option>
                    <option value="pendiente" {{if filtros.estado == 'pendiente'}}selected{{endif filtros.estado == 'pendiente'}}>Pendiente</option>
                    <option value="cancelada" {{if filtros.estado == 'cancelada'}}selected{{endif filtros.estado == 'cancelada'}}>Cancelada</option>
                </select>
            </div>
            <div class="filtro-group">
                <label for="metodoPago">Método de Pago:</label>
                <select id="metodoPago" name="metodoPago">
                    <option value="">Todos</option>
                    <option value="PayPal" {{if filtros.metodoPago == 'PayPal'}}selected{{endif filtros.metodoPago == 'PayPal'}}>PayPal</option>
                    <option value="Tarjeta" {{if filtros.metodoPago == 'Tarjeta'}}selected{{endif filtros.metodoPago == 'Tarjeta'}}>Tarjeta</option>
                </select>
            </div>
            <button type="submit" class="btn-filtrar">Filtrar</button>
            <a href="index.php?page=Admin_Transacciones" class="btn-limpiar">Limpiar</a>
        </form>
    </div>

    <div class="transacciones-admin-list">
        {{if transacciones}}
            <div class="table-responsive">
                <table class="transacciones-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Usuario</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th>Método Pago</th>
                            <th>Libros</th>
                            <th>Total</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        {{foreach transacciones}}
                            <tr>
                                <td>#{{transaccionId}}</td>
                                <td>{{usuario}}</td>
                                <td>{{fecha}}</td>
                                <td><span class="estado estado-{{estado}}">{{estado}}</span></td>
                                <td>{{metodoPago}}</td>
                                <td>{{cantidadLibros}} libro(s)</td>
                                <td>L. {{total}}</td>
                                <td>
                                    <button class="btn-ver-detalles" onclick="toggleDetalles({{transaccionId}})">
                                        Ver Detalles
                                    </button>
                                </td>
                            </tr>
                            <tr id="detalles-{{transaccionId}}" class="detalles-row" style="display: none;">
                                <td colspan="8">
                                    <div class="detalles-container">
                                        <h4>Detalles de la Transacción #{{transaccionId}}</h4>
                                        <div class="detalles-grid">
                                            {{foreach detalles}}
                                                <div class="detalle-item">
                                                    <span class="libro-nombre">{{nombreLibro}}</span>
                                                    <span class="detalle-info">Cant: {{cantidad}} | Precio: L. {{precio}}</span>
                                                    <span class="detalle-subtotal">L. {{precio * cantidad}}</span>
                                                </div>
                                            {{endfor detalles}}
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        {{endfor transacciones}}
                    </tbody>
                </table>
            </div>
        {{endif transacciones}}

        {{ifnot transacciones}}
            <div class="no-transacciones">
                <h3>No se encontraron transacciones</h3>
                <p>Prueba ajustando los filtros de búsqueda</p>
            </div>
        {{endifnot transacciones}}
    </div>
</div>

<script>
function toggleDetalles(transaccionId) {
    const detallesRow = document.getElementById('detalles-' + transaccionId);
    if (detallesRow.style.display === 'none') {
        detallesRow.style.display = 'table-row';
    } else {
        detallesRow.style.display = 'none';
    }
}
</script>