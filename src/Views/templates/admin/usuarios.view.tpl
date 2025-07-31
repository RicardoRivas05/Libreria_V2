<div class="admin-container">
    <div class="admin-header">
        <h1>Gestión de Usuarios</h1>
        <div class="admin-stats">
            <div class="stat-card">
                <span class="stat-number">{{estadisticasGenerales.totalUsuarios}}</span>
                <span class="stat-label">Total Usuarios</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">{{estadisticasGenerales.usuariosActivos}}</span>
                <span class="stat-label">Activos</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">{{estadisticasGenerales.registrosHoy}}</span>
                <span class="stat-label">Registros Hoy</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">{{estadisticasGenerales.registrosUltimoMes}}</span>
                <span class="stat-label">Registros Este Mes</span>
            </div>
        </div>
    </div>

    <div class="busqueda-section">
        <form class="busqueda-form" method="GET">
            <div class="busqueda-group">
                <input type="text" id="busqueda" name="busqueda" placeholder="Buscar por nombre o email..." value="{{filtros.busqueda}}">
                <button type="submit" class="btn-buscar">Buscar</button>
                <a href="index.php?page=Admin_Usuarios" class="btn-limpiar">Limpiar</a>
            </div>
        </form>
    </div>

    <div class="usuarios-admin-list">
        {{if usuarios}}
            <div class="table-responsive">
                <table class="usuarios-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Email</th>
                            <th>Fecha Registro</th>
                            <th>Estado</th>
                            <th>Total Compras</th>
                            <th>Monto Total</th>
                            <th>Última Compra</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        {{foreach usuarios}}
                            <tr>
                                <td>{{userId}}</td>
                                <td>{{nombre}}</td>
                                <td>{{email}}</td>
                                <td>{{fechaRegistro}}</td>
                                <td><span class="estado estado-{{estado}}">{{estado}}</span></td>
                                <td>{{totalCompras}}</td>
                                <td>L. {{montoTotal}}</td>
                                <td>{{ultimaCompra}}</td>
                                <td>
                                    <div class="acciones-grupo">
                                        <button class="btn-ver-perfil" onclick="verPerfil({{userId}})">
                                            Ver Perfil
                                        </button>
                                        {{if estado == 'activo'}}
                                            <button class="btn-desactivar" onclick="cambiarEstado({{userId}}, 'inactivo')">
                                                Desactivar
                                            </button>
                                        {{endif estado == 'activo'}}
                                        {{if estado == 'inactivo'}}
                                            <button class="btn-activar" onclick="cambiarEstado({{userId}}, 'activo')">
                                                Activar
                                            </button>
                                        {{endif estado == 'inactivo'}}
                                    </div>
                                </td>
                            </tr>
                        {{endfor usuarios}}
                    </tbody>
                </table>
            </div>
        {{endif usuarios}}

        {{ifnot usuarios}}
            <div class="no-usuarios">
                <h3>No se encontraron usuarios</h3>
                <p>Prueba ajustando los términos de búsqueda</p>
            </div>
        {{endifnot usuarios}}
    </div>

    <!-- Modal para ver perfil de usuario -->
    <div id="modalPerfil" class="modal" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Perfil de Usuario</h3>
                <span class="close" onclick="cerrarModal()">&times;</span>
            </div>
            <div class="modal-body" id="contenidoPerfil">
                <!-- Aquí se cargará dinámicamente el contenido del perfil -->
            </div>
        </div>
    </div>

    <!-- Gráfico de registros mensuales -->
    {{if estadisticasGenerales.registrosMensuales}}
        <div class="grafico-section">
            <h3>Registros por Mes (Últimos 12 meses)</h3>
            <div class="grafico-container">
                <canvas id="graficoRegistros" width="400" height="200"></canvas>
            </div>
        </div>
    {{endif estadisticasGenerales.registrosMensuales}}
</div>

<script>
function verPerfil(userId) {
    // Aquí puedes hacer una llamada AJAX para obtener más detalles del usuario
    document.getElementById('modalPerfil').style.display = 'block';
    document.getElementById('contenidoPerfil').innerHTML = 'Cargando perfil del usuario ' + userId + '...';
}

function cerrarModal() {
    document.getElementById('modalPerfil').style.display = 'none';
}

function cambiarEstado(userId, nuevoEstado) {
    if (confirm('¿Estás seguro de que quieres cambiar el estado del usuario?')) {
        // Aquí harías una llamada AJAX para cambiar el estado
        fetch('index.php?page=Admin_Usuarios&action=cambiarEstado', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'userId=' + userId + '&estado=' + nuevoEstado
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                location.reload();
            } else {
                alert('Error al cambiar el estado del usuario');
            }
        });
    }
}

// Cerrar modal al hacer clic fuera de él
window.onclick = function(event) {
    const modal = document.getElementById('modalPerfil');
    if (event.target == modal) {
        modal.style.display = 'none';
    }
}

{{if estadisticasGenerales.registrosMensuales}}
// Gráfico de registros mensuales
const ctx = document.getElementById('graficoRegistros').getContext('2d');
const registrosMensuales = [
    {{foreach estadisticasGenerales.registrosMensuales}}
        {mes: '{{mes}}', cantidad: {{cantidadRegistros}}},
    {{endfor estadisticasGenerales.registrosMensuales}}
];

// Implementación simple de gráfico con canvas
function dibujarGrafico() {
    const canvas = document.getElementById('graficoRegistros');
    const ctx = canvas.getContext('2d');
    const width = canvas.width;
    const height = canvas.height;
    
    ctx.clearRect(0, 0, width, height);
    
    if (registrosMensuales.length === 0) return;
    
    const maxValor = Math.max(...registrosMensuales.map(r => r.cantidad));
    const barWidth = width / registrosMensuales.length - 10;
    
    registrosMensuales.forEach((registro, index) => {
        const barHeight = (registro.cantidad / maxValor) * (height - 40);
        const x = index * (barWidth + 10) + 5;
        const y = height - barHeight - 20;
        
        // Dibujar barra
        ctx.fillStyle = '#007bff';
        ctx.fillRect(x, y, barWidth, barHeight);
        
        // Dibujar etiqueta del mes
        ctx.fillStyle = '#333';
        ctx.font = '12px Arial';
        ctx.textAlign = 'center';
        ctx.fillText(registro.mes, x + barWidth/2, height - 5);
        
        // Dibujar valor
        ctx.fillText(registro.cantidad, x + barWidth/2, y - 5);
    });
}

dibujarGrafico();
{{endif estadisticasGenerales.registrosMensuales}}
</script>