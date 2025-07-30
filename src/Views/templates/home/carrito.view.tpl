<section style="max-width: 1000px; margin: 2rem auto; padding: 1.5rem 2rem; background: #fff; border: 1px solid #ccc; border-radius: 6px; font-family: Georgia, serif; color: #222;">
    <h1 style="font-weight: normal; font-size: 2.5rem; border-bottom: 2px solid #555; padding-bottom: 0.4rem; margin-bottom: 1rem;">
        Carrito de Compras
    </h1>
    <p style="font-size: 1.1rem; line-height: 1.5; color: #444;">
        Hola {{usuario}}, revisa los libros que has seleccionado.
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
       Seguir Comprando
    </a>
    <a href="index.php?page=Home_Login" 
       style="display: inline-block; background: #eee; color: #444; padding: 0.5rem 1.2rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
       Iniciar Sesión
    </a>
</section>

<!-- Mensajes de confirmación -->
{{if mensaje}}
<div style="max-width: 1000px; margin: 1rem auto; padding: 1rem; text-align: center; border-radius: 4px; 
    {{if mensaje == 'agregado'}}background: #d4edda; color: #155724; border: 1px solid #c3e6cb;{{endif}}
    {{if mensaje == 'eliminado'}}background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;{{endif}}
    {{if mensaje == 'vaciado'}}background: #fff3cd; color: #856404; border: 1px solid #ffeaa7;{{endif}}">
    {{if mensaje == 'agregado'}}✓ Libro agregado al carrito exitosamente{{endif}}
    {{if mensaje == 'eliminado'}}✗ Libro eliminado del carrito{{endif}}
    {{if mensaje == 'vaciado'}}🗑️ Carrito vaciado completamente{{endif}}
</div>
{{endif}}

<!-- Contenido del carrito -->
<section style="max-width: 1000px; margin: 2rem auto; padding: 1.5rem 2rem; background: #fff; border: 1px solid #ccc; border-radius: 6px;">
    
    {{if carrito|@count > 0}}
    
    <!-- Resumen del carrito -->
    <div style="background: #f8f9fa; padding: 1rem; border-radius: 4px; margin-bottom: 2rem; text-align: center;">
        <strong style="font-size: 1.2rem; color: #333;">
            Tienes {{cantidad_items}} {{if cantidad_items == 1}}libro{{else}}libros{{endif}} en tu carrito
        </strong>
    </div>
    
    <!-- Lista de productos -->
    <div style="overflow-x: auto;">
        <table style="width: 100%; border-collapse: collapse; margin-bottom: 2rem;">
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
                        <div style="display: flex; align-items: center;">
                            <div style="width: 60px; height: 80px; background: #f5f5f5; border-radius: 4px; margin-right: 1rem; overflow: hidden; flex-shrink: 0;">
                                <img src="/3P/Libreria_V2/public/imgs/libros/{{codLibro}}.jpg" 
                                     alt="{{nombre}}"
                                     style="width: 100%; height: 100%; object-fit: cover;"
                                     onerror="this.src='/3P/Libreria_V2/public/imgs/libros/default.jpg'">
                            </div>
                            <div>
                                <strong style="font-size: 1.1rem; color: #333;">{{nombre}}</strong>
                                <div style="font-size: 0.9rem; color: #666; margin-top: 0.25rem;">Código: {{codLibro}}</div>
                            </div>
                        </div>
                    </td>
                    <td style="padding: 1rem; text-align: center; font-size: 1.1rem; color: #e74c3c; font-weight: 600;">
                        L. {{precio}}
                    </td>
                    <td style="padding: 1rem; text-align: center;">
                        <form method="post" action="index.php?page=Home_Carrito" style="display: inline-flex; align-items: center;">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="codLibro" value="{{codLibro}}">
                            <input type="number" name="cantidad" value="{{cantidad}}" min="1" max="99" 
                                   style="width: 60px; padding: 0.25rem; border: 1px solid #ccc; border-radius: 4px; text-align: center; margin-right: 0.5rem;">
                            <button type="submit" style="background: #007bff; color: white; border: none; padding: 0.25rem 0.5rem; border-radius: 4px; cursor: pointer; font-size: 0.85rem;">
                                ✓
                            </button>
                        </form>
                    </td>
                    <td style="padding: 1rem; text-align: center; font-size: 1.1rem; font-weight: 600; color: #333;">
                        L. {{precio * cantidad}}
                    </td>
                    <td style="padding: 1rem; text-align: center;">
                        <form method="post" action="index.php?page=Home_Carrito" style="display: inline;">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="codLibro" value="{{codLibro}}">
                            <button type="submit" onclick="return confirm('¿Estás seguro de eliminar este libro del carrito?')"
                                    style="background: #dc3545; color: white; border: none; padding: 0.5rem 0.75rem; border-radius: 4px; cursor: pointer; font-size: 0.85rem;">
                                🗑️ Eliminar
                            </button>
                        </form>
                    </td>
                </tr>
                {{endfor carrito}}
            </tbody>
        </table>
    </div>
    
    <!-- Total y acciones -->
    <div style="border-top: 2px solid #dee2e6; padding-top: 1.5rem;">
        <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
            <div>
                <form method="post" action="index.php?page=Home_Carrito" style="display: inline;">
                    <input type="hidden" name="accion" value="vaciar">
                    <button type="submit" onclick="return confirm('¿Estás seguro de vaciar todo el carrito?')"
                            style="background: #6c757d; color: white; border: none; padding: 0.75rem 1.5rem; border-radius: 4px; cursor: pointer; font-size: 1rem;">
                        🗑️ Vaciar Carrito
                    </button>
                </form>
            </div>
            
            <div style="text-align: right;">
                <div style="font-size: 1.5rem; font-weight: bold; color: #333; margin-bottom: 1rem;">
                    Total: <span style="color: #e74c3c;">L. {{total}}</span>
                </div>
                <button type="button" onclick="alert('Funcionalidad de pago próximamente')"
                        style="background: #28a745; color: white; border: none; padding: 1rem 2rem; border-radius: 4px; cursor: pointer; font-size: 1.1rem; font-weight: 600;">
                    💳 Proceder al Pago
                </button>
            </div>
        </div>
    </div>
    
    {{else}}
    
    <!-- Carrito vacío -->
    <div style="text-align: center; padding: 3rem 1rem;">
        <div style="font-size: 4rem; margin-bottom: 1rem;">🛒</div>
        <h2 style="color: #666; margin-bottom: 1rem;">Tu carrito está vacío</h2>
        <p style="color: #888; margin-bottom: 2rem; font-size: 1.1rem;">
            ¡Explora nuestro catálogo y encuentra los libros que más te gusten!
        </p>
        <a href="index.php?page=Catalogo" 
           style="display: inline-block; background: #007bff; color: white; padding: 1rem 2rem; text-decoration: none; font-weight: 600; border-radius: 4px; font-size: 1.1rem;">
           📚 Ver Catálogo
        </a>
    </div>
    
    {{endif}}
    
</section>

<style>
/* Estilos responsivos */
@media (max-width: 768px) {
    table {
        font-size: 0.9rem;
    }
    
    td, th {
        padding: 0.5rem !important;
    }
    
    .total-section {
        flex-direction: column;
        align-items: stretch !important;
    }
    
    .total-section > div {
        text-align: center !important;
        margin-bottom: 1rem;
    }
}

/* Animaciones suaves */
button {
    transition: all 0.3s ease;
}

button:hover {
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}

input[type="number"]:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
}
</style>