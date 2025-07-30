<h1>Libros Recomendados</h1>
<div class="product-list">
  {{foreach libros}}
  <div class="product" data-productId="{{codLibro}}">
    <img src="/public/imgs/libros/{{codLibro}}.jpg" alt="{{nombre}}">
    <h2>{{nombre}}</h2>
    <p>{{descripcion}}</p>
    <span class="price">L. {{precio}}</span>
    <span class="stock">Disponible {{stock}}</span>
    <form action="index.php?page=Home_Carrito" method="post">
        <input type="hidden" name="codLibro" value="{{codLibro}}">
        <button type="submit" class="add-to-cart">
          <i class="fa-solid fa-cart-plus"></i>Agregar al Carrito
        </button>
    </form>
  </div>
  {{endfor libros}}
</div>