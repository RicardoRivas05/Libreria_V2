<section style="max-width: 900px; margin: 2rem auto; padding: 1.5rem 2rem; background: #fff; border: 1px solid #ccc; border-radius: 6px; font-family: Georgia, serif; color: #222;">
    <h1 style="font-weight: normal; font-size: 2.5rem; border-bottom: 2px solid #555; padding-bottom: 0.4rem; margin-bottom: 1rem;">Bienvenido a la Biblioteca Virtual</h1>
    <p style="font-size: 1.1rem; line-height: 1.5; color: #444;">Hola {{usuario}}, descubre cientos de libros digitales disponibles para ti.</p>
</section>

<section style="max-width: 900px; margin: 2rem auto; padding: 1rem 2rem; text-align: center;">
    <a href="index.php?page=Catalogo" 
       style="display: inline-block; background: #444; color: #fff; padding: 0.5rem 1.2rem; margin-right: 1rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
       Ver Catálogo
    </a>
    <a href="index.php?page=Home_Carrito"
   style="display: inline-block; background: #eee; color: #444; padding: 0.5rem 1.2rem; margin-right: 1rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
   Carrito de Compras
</a>
    </a>
    <a href="index.php?page=Home_Login" 
       style="display: inline-block; background: #eee; color: #444; padding: 0.5rem 1.2rem; text-decoration: none; font-weight: 600; border-radius: 4px;">
       Iniciar Sesión
    </a>
</section>

  <h2 style="text-align: center; color: #333; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid #ddd;">Libros Recomendados</h2>

     <div style="display: grid; grid-template-columns: repeat(4, 260px); gap: 25px; justify-content: center; padding: 10px;">
        {{foreach libros}}
        <div style="border: 1px solid #e0e0e0; border-radius: 8px; padding: 15px; text-align: center; background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.05); height: 100%;">
            <div style="height: 160px; background-color: #f5f5f5; border-radius: 4px; margin-bottom: 15px; display: flex; align-items: center; justify-content: center; overflow: hidden;">
    <img src="/MVC2025/public/imgs/libros/{{codLibro}}.jpg" 
         alt="{{nombre}}"
         style="max-height: 100%; max-width: 100%; object-fit: contain;"
         onerror="this.src='/MVC2025/public/imgs/libros/default.jpg'">
</div>
            
            <div style="font-weight: bold; font-size: 1.1rem; margin-bottom: 5px; color: #2c3e50;">{{nombre}}</div>
            <div style="font-size: 1.2rem; color: #e74c3c; margin-bottom: 10px;">L. {{precio}}</div>
            <div style="font-size: 0.9rem; color: #555; margin-bottom: 15px; min-height: 60px; line-height: 1.4;">{{descripcion}}</div>
            <div style="margin-bottom: 15px; font-size: 0.85rem; color: #7f8c8d;">Disponibles: {{stock}}</div>
            
            <form method="post" action="index.php?page=Home_Carrito">
                <input type="hidden" name="codLibro" value="{{codLibro}}">
                <input type="hidden" name="nombre" value="{{nombre}}">
                <input type="hidden" name="precio" value="{{precio}}">
                <button type="submit" style="background-color: #27ae60; color: white; border: none; padding: 8px 15px; border-radius: 4px; cursor: pointer; width: 100%; font-size: 0.9rem; transition: background-color 0.3s;">
                    Agregar al Carrito
                </button>
            </form>
        </div>
        {{endfor libros}}
    </div>