document.addEventListener('DOMContentLoaded', function() {
    
    const minPriceInput = document.querySelector('input[name="min"]');
    const maxPriceInput = document.querySelector('input[name="max"]');
    
    if (minPriceInput && maxPriceInput) {
        minPriceInput.addEventListener('change', function() {
            if (parseFloat(this.value) > parseFloat(maxPriceInput.value)) {
                maxPriceInput.value = this.value;
            }
        });
        
        maxPriceInput.addEventListener('change', function() {
            if (parseFloat(this.value) < parseFloat(minPriceInput.value)) {
                minPriceInput.value = this.value;
            }
        });
    }
    
    
    const booksGrid = document.querySelector('.books-grid');
    if (booksGrid && booksGrid.children.length === 0) {
        const noResults = document.createElement('div');
        noResults.className = 'no-results';
        noResults.innerHTML = '<p>No se encontraron libros que coincidan con tu búsqueda.</p>';
        booksGrid.appendChild(noResults);
    }
});