<section style="max-width: 1000px; margin: 2rem auto; padding: 1.5rem 2rem; background: #fff; border: 1px solid #ccc; border-radius: 6px; font-family: Georgia, serif; color: #222;">
    <h1 style="font-weight: normal; font-size: 2.5rem; border-bottom: 2px solid #555; padding-bottom: 0.4rem; margin-bottom: 1rem;">
        Carrito de Compras
    </h1>
    <p style="font-size: 1.1rem; line-height: 1.5; color: #444;">
        Hola {{usuario}}, aquí tienes los libros que has seleccionado.
    </p>
</section>

<!-- Navegación -->
<section style="max-width: 1000px; margin: 1rem auto; padding: 1rem 2rem; text-align: center;">
    <a href="index.php?page=Home" 
       style="display: inline-block; background: #eee; color: #444; padding: 0.5rem 1.2rem; margin-right: 1rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
       Inicio
    </a>
    <a href="index.php?page=Catalogo"
       style="display: inline-block; background: #eee; color: #444; padding: 0.5rem 1.2rem; margin-right: 1rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
       Continuar Comprando
    </a>
    <a href="index.php?page=Home_Carrito" 
       style="display: inline-block; background: #444; color: #fff; padding: 0.5rem 1.2rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
       Carrito ({{totalItems}})
    </a>
</section>

<!-- Mensaje de estado -->
{{if mensaje}}
<div style="max-width: 1000px; margin: 1rem auto; padding: 1rem 2rem;">
    <div style="background: #d4edda; color: #155724; padding: 0.75rem 1rem; border: 1px solid #c3e6cb; border-radius: 4px; margin-bottom: 1rem;">
        {{mensaje}}
    </div>
</div>
{{endif mensaje}}

<!-- Contenido del carrito -->
<div style="max-width: 1000px; margin: 2rem auto; padding: 1rem 2rem;">
        <!-- Tabla del carrito -->
        <div style="background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
            <table style="width: 100%; border-collapse: collapse;">
                <thead>
                    <tr style="background: #f8f9fa; border-bottom: 2px solid #dee2e6;">
                        <th style="padding: 1rem; text-align: left; font-weight: 600; color: #495057;">Libro</th>
                        <th style="padding: 1rem; text-align: center; font-weight: 600; color: #495057;">Precio</th>
                        <th style="padding: 1rem; text-align: center; font-weight: 600; color: #495057;">Cantidad</th>
                        <th style="padding: 1rem; text-align: center; font-weight: 600; color: #495057;">Subtotal</th>
                        <th style="padding: 1rem; text-align: center; font-weight: 600; color: #495057;">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    {{foreach carrito}}
                    <tr style="border-bottom: 1px solid #dee2e6;">
                        <td style="padding: 1rem;">
                            <div style="display: flex; align-items: center; gap: 1rem;">
                                <div style="width: 60px; height: 80px; background: #f5f5f5; border-radius: 4px; display: flex; align-items: center; justify-content: center; overflow: hidden; flex-shrink: 0;">
                                    <img src="public/imgs/libros/{{codLibro}}.jpg" 
                                         alt="{{nombre}}"
                                         style="max-height: 100%; max-width: 100%; object-fit: contain;"
                                         onerror="this.src='public/imgs/libros/default.jpg'">
                                </div>
                                <div>
                                    <div style="font-weight: 600; color: #212529; margin-bottom: 0.25rem;">{{nombre}}</div>
                                    <div style="font-size: 0.9rem; color: #6c757d;">Código: {{codLibro}}</div>
                                </div>
                            </div>
                        </td>
                        <td style="padding: 1rem; text-align: center; font-weight: 600; color: #e74c3c;">
                            L. {{precio}}
                        </td>
                        <td style="padding: 1rem; text-align: center;">
                            <form method="post" action="index.php?page=Home_Carrito" style="display: inline-block;">
                                <input type="hidden" name="accion" value="actualizar">
                                <input type="hidden" name="codLibro" value="{{codLibro}}">
                                <div style="display: flex; align-items: center; justify-content: center; gap: 0.5rem;">
                                    <input type="number" name="cantidad" value="{{cantidad}}" min="1" max="50"
                                           style="width: 60px; padding: 0.25rem; border: 1px solid #ced4da; border-radius: 4px; text-align: center;">
                                    <button type="submit" 
                                            style="background: #28a745; color: white; border: none; padding: 0.25rem 0.5rem; border-radius: 4px; cursor: pointer; font-size: 0.8rem;">
                                        ✓
                                    </button>
                                </div>
                            </form>
                        </td>
                        <td style="padding: 1rem; text-align: center; font-weight: 600; color: #212529;">
                            L. {{subtotal}}
                        </td>
                        <td style="padding: 1rem; text-align: center;">
                            <form method="post" action="index.php?page=Home_Carrito" style="display: inline-block;">
                                <input type="hidden" name="accion" value="eliminar">
                                <input type="hidden" name="codLibro" value="{{codLibro}}">
                                <button type="submit" 
                                        onclick="return confirm('¿Estás seguro de que quieres eliminar este libro del carrito?')"
                                        style="background: #dc3545; color: white; border: none; padding: 0.5rem 0.75rem; border-radius: 4px; cursor: pointer; font-size: 0.9rem;">
                                    🗑️ Eliminar
                                </button>
                            </form>
                        </td>
                    </tr>
                    {{endfor carrito}}
                </tbody>
            </table>
        </div>

        <!-- Resumen del carrito -->
        <div style="margin-top: 2rem; display: grid; grid-template-columns: 1fr 300px; gap: 2rem;">
            <!-- Acciones del carrito -->
            <div style="display: flex; gap: 1rem; align-items: flex-start;">
                <form method="post" action="index.php?page=Home_Carrito">
                    <input type="hidden" name="accion" value="vaciar">
                    <button type="submit" 
                            onclick="return confirm('¿Estás seguro de que quieres vaciar todo el carrito?')"
                            style="background: #6c757d; color: white; border: none; padding: 0.75rem 1.5rem; border-radius: 4px; cursor: pointer; font-weight: 600;">
                        Vaciar Carrito
                    </button>
                </form>
            </div>

            <!-- Totales -->
            <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 8px; border: 1px solid #dee2e6;">
                <h3 style="margin: 0 0 1rem 0; color: #495057; font-size: 1.25rem;">Resumen del Pedido</h3>
                
                <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem; padding-bottom: 0.5rem;">
                    <span style="color: #6c757d;">Subtotal:</span>
                    <span style="font-weight: 600; color: #212529;">L. {{subtotal}}</span>
                </div>
                
                <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem; padding-bottom: 0.5rem;">
                    <span style="color: #6c757d;">Impuesto (15%):</span>
                    <span style="font-weight: 600; color: #212529;">L. {{impuesto}}</span>
                </div>
                
                <hr style="margin: 1rem 0; border: none; border-top: 1px solid #dee2e6;">
                
                <div style="display: flex; justify-content: space-between; margin-bottom: 1.5rem;">
                    <span style="font-size: 1.1rem; font-weight: 600; color: #212529;">Total:</span>
                    <span style="font-size: 1.2rem; font-weight: 700; color: #e74c3c;">L. {{total}}</span>
                </div>
                
                <div id="paypal-button-container"></div>
                
                <div style="margin-top: 1rem; text-align: center;">
                    <small style="color: #6c757d;">{{totalItems}} libro(s) en tu carrito</small>
                </div>
            </div>
        </div>
    {{endif carritoVacio}}
</div>

<script src="https://www.paypal.com/sdk/js?client-id={{PAYPAL_CLIENT_ID}}&currency=USD"></script>
<script>
    paypal.Buttons({
        createOrder: function(data, actions) {
            return actions.order.create({
                purchase_units: [{
                    amount: {
                        value: '{{totalUSD}}'
                    },
                    description: "Compra en Librería ({{totalItems}} libro(s))"
                }]
            });
        },
        onApprove: function(data, actions) {
            return actions.order.capture().then(function(details) {
                window.location.href = "index.php?page=Checkout_Confirmacion&paymentId=" + data.orderID + "&payer=" + details.payer.name.given_name;
            });
        }
    }).render('#paypal-button-container');
</script>