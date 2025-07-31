<div class="historial-container">
    <div class="historial-header">
        <h1>Mi Historial de Compras</h1>
        <div class="historial-stats">
            <div class="stat-card">
                <span class="stat-number">{{totalTransacciones}}</span>
                <span class="stat-label">Transacciones</span>
            </div>
            <div class="stat-card">
                <span class="stat-number">L. {{totalGeneral}}</span>
                <span class="stat-label">Total Gastado</span>
            </div>
        </div>
    </div>

    {{if historial}}
        <div class="transacciones-list">
            {{foreach historial}}
                <div class="transaccion-card">
                    <div class="transaccion-header">
                        <div class="transaccion-info">
                            <h3>Transacción #{{transaccionId}}</h3>
                            <p class="fecha">{{fecha}}</p>
                        </div>
                        <div class="transaccion-status">
                            <span class="estado estado-{{estado}}">{{estado}}</span>
                            <p class="metodo-pago">{{metodoPago}}</p>
                        </div>
                        <div class="transaccion-total">
                            <span class="total-amount">L. {{subtotal}}</span>
                        </div>
                    </div>
                    
                    <div class="transaccion-detalles">
                        <h4>Libros comprados:</h4>
                        <div class="libros-grid">
                            {{foreach detalles}}
                                <div class="libro-item">
                                    <div class="libro-info">
                                        <h5>{{nombreLibro}}</h5>
                                        <p>Cantidad: {{cantidad}}</p>
                                        <p>Precio unitario: L. {{precio}}</p>
                                    </div>
                                    <div class="libro-subtotal">
                                        L. {{precio * cantidad}}
                                    </div>
                                </div>
                            {{endfor detalles}}
                        </div>
                    </div>
                </div>
            {{endfor historial}}
        </div>
    {{endif historial}}

    {{ifnot historial}}
        <div class="no-historial">
            <div class="no-historial-icon">📚</div>
            <h2>Aún no has realizado compras</h2>
            <p>Explora nuestro catálogo y realiza tu primera compra</p>
            <a href="index.php?page=Home" class="btn-primary">Ver Catálogo</a>
        </div>
    {{endifnot historial}}
</div>