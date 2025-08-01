<section style="max-width: 400px; margin: 3rem auto; padding: 2rem; background: #fff; border: 1px solid #ccc; border-radius: 6px; font-family: Georgia, serif; color: #222;">
    <h1 style="font-weight: normal; font-size: 2rem; margin-bottom: 1.5rem; border-bottom: 2px solid #555; padding-bottom: 0.4rem;">
        Registro de Usuario
    </h1>

    <?php if (!empty($error)) : ?>
        <p style="color: red; font-weight: bold; font-size: 0.9rem;"><?= htmlspecialchars($error) ?></p>
    <?php endif; ?>

    <form method="post" action="index.php?page=Home_Register" style="display: flex; flex-direction: column; gap: 1rem;">
        <label for="email" style="font-weight: 600;">Correo electrónico</label>
        <input type="email" id="email" name="email" required 
               style="padding: 0.5rem; font-size: 1rem; border: 1px solid #ccc; border-radius: 4px;">
        
        <label for="password" style="font-weight: 600;">Contraseña</label>
        <input type="password" id="password" name="password" required
               style="padding: 0.5rem; font-size: 1rem; border: 1px solid #ccc; border-radius: 4px;">

        <label for="password_confirm" style="font-weight: 600;">Confirmar Contraseña</label>
        <input type="password" id="password_confirm" name="password_confirm" required
               style="padding: 0.5rem; font-size: 1rem; border: 1px solid #ccc; border-radius: 4px;">

        <label style="font-size: 0.9rem;">
            <input type="checkbox" onclick="let p1 = document.getElementById('password'); let p2 = document.getElementById('password_confirm'); p1.type = this.checked ? 'text' : 'password'; p2.type = this.checked ? 'text' : 'password';">
            Mostrar contraseñas
        </label>

        <button type="submit" 
                style="margin-top: 1rem; background: #444; color: #fff; padding: 0.6rem; font-weight: 600; border: none; border-radius: 6px; cursor: pointer;">
            Registrarse
        </button>
    </form>
</section>

