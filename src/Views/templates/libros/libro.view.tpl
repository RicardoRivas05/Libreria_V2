<section class="book-detail">
    <div class="book-detail__header">
        <h1 class="book-detail__title">{{titulo}}</h1>
        <div class="book-detail__meta">
            <span class="book-meta__genre">{{genero}}</span>
            {{if stock}}
            <span class="book-meta__stock">Disponible ({{stock}} unidades)</span>
            {{endif stock}}
        </div>
    </div>
    
    <div class="book-detail__content">
        <div class="book-detail__image-container">
            <img src="{{imagenUrl}}" alt="Portada de {{titulo}}" class="book-detail__image">
            {{ifnot disponible}}
            <div class="book-detail__badge out-of-stock">AGOTADO</div>
            {{endifnot disponible}}
        </div>
        
        <div class="book-detail__info">
            <div class="book-info__section">
                <h2 class="book-info__heading">Información del Libro</h2>
                <ul class="book-info__list">
                    <li><strong>Autor:</strong> {{autor}}</li>
                    <li><strong>Fecha de Publicación:</strong> {{fechaPublicacion}}</li>
                    <li><strong>ISBN:</strong> {{isbn}}</li>
                    <li><strong>Precio:</strong> <span class="book-price">L. {{precio}}</span></li>
                </ul>
            </div>
            
            <div class="book-info__section">
                <h2 class="book-info__heading">Descripción</h2>
                <div class="book-description">
                    {{descripcion}}
                </div>
            </div>

            <div class="book-detail__actions">
                {{if disponible}}
                <form method="post" action="{{urlCarrito}}" class="add-to-cart-form">
                    <button type="submit" class="action-btn primary">
                        <i class="fas fa-cart-plus"></i> Agregar al Carrito
                    </button>
                </form>
                {{endif disponible}}
                
                <div class="action-buttons">
                    <a href="index.php?page=Libros_Libros" class="action-btn secondary">
                        <i class="fas fa-arrow-left"></i> Volver al Catálogo
                    </a>
                    <a href="index.php?page=Home_Carrito" class="action-btn secondary">
                        <i class="fas fa-shopping-cart"></i> Ver Carrito
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

{{if libros_relacionados}}
<section class="related-books">
    <h2 class="section-title">Libros Relacionados</h2>
    <div class="related-books__grid">
        {{foreach libros_relacionados}}
        <div class="related-book">
            <a href="{{urlDetalle}}" class="related-book__link">
                <div class="related-book__image-container">
                    <img src="{{imagenUrl}}" alt="{{titulo}}" class="related-book__image">
                    <div class="related-book__overlay">
                        <span class="related-book__price">L. {{precio}}</span>
                    </div>
                </div>
                <div class="related-book__info">
                    <h3 class="related-book__title">{{titulo}}</h3>
                    <p class="related-book__author">{{autor}}</p>
                </div>
            </a>
        </div>
        {{endfor libros_relacionados}}
    </div>
</section>
{{endif libros_relacionados}}