<div class="libro-detalle-container fade-in">
    <div class="libro-detalle">
        <div class="libro-imagen-detalle">
            <img src="{{libro.imagenUrl}}" 
                 alt="{{libro.titulo}}" 
                 onerror="this.src='public/images/libro-default.jpg'">
        </div>
        
        <div class="libro-info-detalle">
            <h1 class="libro-titulo-detalle">{{libro.titulo}}</h1>
            
            <div class="libro-meta-detalle">
                <div class="meta-item-detalle">
                    <div class="meta-label-detalle"> Autor</div>
                    <div class="meta-value-detalle">{{libro.autor}}</div>
                </div>
                
                <div class="meta-item-detalle">
                    <div class="meta-label-detalle"> Género</div>
                    <div class="meta-value-detalle">{{libro.genero}}</div>
                </div>
                
                <div class="meta-item-detalle">
                    <div class="meta-label-detalle"> Disponibilidad</div>
                    <div class="meta-value-detalle">
                        {{if libro.disponible}}
                             En stock
                        {{else}}
                             Agotado
                        {{endif}}
                    </div>
                </div>
                
                <div class="meta-item-detalle">
                    <div class="meta-label-detalle"> Agregado</div>
                    <div class="meta-value-detalle">{{libro.creadoEn}}</div>
                </div>
            </div>
            
            <div class="libro-precio-detalle">
                 L. {{libro.precio}}
            </div>
            
            <div class="libro-descripcion-detalle">
                <h3> Descripción</h3>
                <p>{{libro.descripcion}}</p>
            </div>
            
            <div class="libro-acciones-detalle">
                <a href="index.php?page=Carrito_Agregar&id={{libro.libroId}}" 
                   class="btn btn-success" id="btnAddCart">
                     Agregar al Carrito
                </a>
                
                <a href="index.php?page=Libros_Libros" class="btn btn-outline">
                    ← Volver al Catálogo
                </a>
            </div>
        </div>
    </div>
    
    {{if librosRelacionados}}
    <div class="libros-relacionados">
        <h3>📚 Libros Relacionados</h3>
        <div class="books-grid">
            {{foreach librosRelacionados}}
            <div class="book-card">
                <div class="book-image-container">
                    <img src="{{imagenUrl}}" alt="{{titulo}}">
                </div>
                <div class="book-content">
                    <h3>{{titulo}}</h3>
                    <p class="book-author">{{autor}}</p>
                    <div class="book-price">L. {{precio}}</div>
                    <a href="index.php?page=Libros_Libro&id={{libroId}}" class="btn btn-details">
                        Ver Detalles
                    </a>
                </div>
            </div>
            {{endfor}}
        </div>
    </div>
    {{endif}}
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Feedback al agregar al carrito
    const btnCart = document.getElementById('btnAddCart');
    if (btnCart) {
        btnCart.addEventListener('click', function(e) {
            const originalText = this.innerHTML;
            this.innerHTML = ' Agregando...';
            setTimeout(() => {
                this.innerHTML = originalText;
            }, 1000);
        });
    }

    // Zoom en imagen
    const img = document.querySelector('.libro-imagen-detalle img');
    if (img) {
        img.addEventListener('click', function() {
            const modal = document.createElement('div');
            modal.style.cssText = `
                position: fixed;
                top: 0; left: 0;
                width: 100%; height: 100%;
                background: rgba(0,0,0,0.9);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1000;
                cursor: zoom-out;
            `;
            
            const imgModal = document.createElement('img');
            imgModal.src = this.src;
            imgModal.style.maxHeight = '90%';
            imgModal.style.maxWidth = '90%';
            
            modal.appendChild(imgModal);
            document.body.appendChild(modal);
            
            modal.addEventListener('click', () => {
                document.body.removeChild(modal);
            });
        });
    }
});
</script>