<div class="catalogo-container fade-in">
    <div class="catalogo-header">
        <h1> Catálogo de Libros</h1>
        <div class="catalogo-actions">
            <a href="index.php?page=Carrito" class="btn btn-cart">
                🛒 Ver Carrito
            </a>
        </div>
    </div>

    <div class="filtros-container">
        <form method="get" action="index.php" class="filtros-form">
            <input type="hidden" name="page" value="Libros_Libros">
            
            <div class="filtro-group">
                <label>Autor:</label>
                <select name="autor" class="filtro-select">
                    <option value="">Todos los autores</option>
                    {{foreach autoresDisponibles}}
                    <option value="{{autor}}" {{if autor == @autor}}selected{{endif}}>
                        {{autor}}
                    </option>
                    {{endfor}}
                </select>
            </div>
            
            <div class="filtro-group">
                <label>Género:</label>
                <select name="genero" class="filtro-select">
                    <option value="">Todos los géneros</option>
                    {{foreach generosDisponibles}}
                    <option value="{{genero}}" {{if genero == @genero}}selected{{endif}}>
                        {{genero}}
                    </option>
                    {{endfor}}
                </select>
            </div>
            
            <div class="filtro-group">
                <label>Precio:</label>
                <div class="price-range">
                    <input type="number" name="min" placeholder="Mín" value="{{min}}" min="0">
                    <span>a</span>
                    <input type="number" name="max" placeholder="Máx" value="{{max}}" min="0">
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary">Filtrar</button>
            <a href="index.php?page=Libros_Libros" class="btn btn-secondary">Limpiar</a>
        </form>
    </div>

    {{if error}}
    <div class="alert alert-danger">
         {{error}}
    </div>
    {{endif}}

    <div class="books-grid">
        {{foreach libros}}
        <div class="book-card {{if destacado}}destacado{{endif}}">
            {{if destacado}}
            <div class="book-badge"> Destacado</div>
            {{endif}}
            
            <div class="book-image-container">
                <img src="{{imagenUrl}}" alt="{{titulo}}" 
                     onerror="this.src='public/images/libro-default.jpg'">
            </div>
            
            <div class="book-content">
                <h3 class="book-title">{{titulo}}</h3>
                <p class="book-author">{{autor}}</p>
                
                <div class="book-meta">
                    <span class="book-genre">{{genero}}</span>
                    <span class="book-price">L. {{precio}}</span>
                </div>
                
                <div class="book-actions">
                    <a href="{{urlDetalle}}" class="btn btn-details">
                        Ver Detalles
                    </a>
                    <a href="{{urlCarrito}}" class="btn btn-cart">
                        🛒 Agregar
                    </a>
                </div>
            </div>
        </div>
        {{endfor}}
    </div>
    
    {{if not libros}}
    <div class="no-results">
        <p>No se encontraron libros con los filtros aplicados.</p>
        <a href="index.php?page=Libros_Libros" class="btn btn-primary">
            Ver todos los libros
        </a>
    </div>
    {{endif}}
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Validación de precios en el formulario
    const form = document.querySelector('.filtros-form');
    form.addEventListener('submit', function(e) {
        const min = parseFloat(this.elements.min.value) || 0;
        const max = parseFloat(this.elements.max.value) || 9999;
        
        if (min > max) {
            alert('El precio mínimo no puede ser mayor al máximo');
            e.preventDefault();
        }
    });

    // Animación de tarjetas
    const cards = document.querySelectorAll('.book-card');
    cards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });
});
</script>