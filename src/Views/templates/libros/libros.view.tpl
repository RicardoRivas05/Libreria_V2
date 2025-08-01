<section style="max-width: 1000px; margin: 1rem auto; padding: 1rem 2rem; text-align: center;">
    <a href="index.php?page=Home_Home" 
       style="display: inline-block; background: #eee; color: #444; padding: 0.5rem 1.2rem; margin-right: 1rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
       Inicio
    </a>
    <a href="index.php?page=Libros_Libros"
       style="display: inline-block; background: #eee; color: #444; padding: 0.5rem 1.2rem; margin-right: 1rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
       Catalogo
    </a>
    <a href="index.php?page=Home_Carrito" 
       style="display: inline-block; background: #444; color: #fff; padding: 0.5rem 1.2rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
       Carrito ({{totalItems}})
    </a>
</section>

<section class="books-catalog">
    <h1 class="books-catalog__title">Catálogo de Libros</h1>

    <div class="books-filters">
        <form method="get" action="index.php" class="filter-form">
            <input type="hidden" name="page" value="Libros_Libros">
            
            <div class="filter-group">
                <label for="autor">Autor:</label>
                <input type="text" id="autor" name="autor" value="{{filtro_autor}}" placeholder="Filtrar por autor">
            </div>
            
            <div class="filter-group">
                <label for="genero">Género:</label>
                <select id="genero" name="genero">
                    <option value="">Todos los géneros</option>
                    {{foreach generos}}
                    <option value="{{this}}" {{if filtro_genero=this}}selected{{endif filtro_genero=this}}>{{this}}</option>
                    {{endfor generos}}
                </select>
            </div>
            
            <div class="filter-group">
                <label>Rango de precios:</label>
                <div class="price-range">
                    <input type="number" name="precio_min" value="{{filtro_precio_min}}" placeholder="Mínimo" min="0" step="0.01">
                    <span>a</span>
                    <input type="number" name="precio_max" value="{{filtro_precio_max}}" placeholder="Máximo" min="0" step="0.01">
                </div>
            </div>
            
            <div class="filter-actions">
                <button type="submit" class="filter-btn">Filtrar</button>
                <a href="index.php?page=Libros_Libros" class="clear-btn">Limpiar</a>
            </div>
        </form>
    </div>

    {{if libros}}
    <div class="books-grid">
        {{foreach libros}}
        <div class="book-card">
            <a href="{{urlDetalle}}" class="book-card__link">
                <div class="book-card__image-container">
                    <img src="{{imagenUrl}}" alt="{{titulo}}" class="book-card__image">
                    {{if disponible}}
                    <span class="book-card__availability available">Disponible</span>
                    {{endif disponible}}
                    {{ifnot disponible}}
                    <span class="book-card__availability unavailable">Agotado</span>
                    {{endifnot disponible}}
                </div>
                <div class="book-card__info">
                    <h3 class="book-card__title">{{titulo}}</h3>
                    <p class="book-card__author">{{autor}}</p>
                    <p class="book-card__genre">{{genero}}</p>
                    <p class="book-card__price">L. {{precio}}</p>
                </div>
            </a>
            {{if disponible}}
            <form method="post" action="{{urlCarrito}}" class="book-card__form">
                <button type="submit" class="add-to-cart-btn">Agregar al carrito</button>
            </form>
            {{endif disponible}}
        </div>
        {{endfor libros}}
    </div>
    {{endif libros}}

    {{ifnot libros}}
    <div class="no-results">
        <p>No se encontraron libros con los filtros seleccionados.</p>
        <a href="index.php?page=Libros_Libros" class="reset-link">Ver todos los libros</a>
    </div>
    {{endifnot libros}}
</section>