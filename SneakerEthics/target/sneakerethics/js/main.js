// DOM Elements
const searchInput = document.querySelector('.search-input');
const sneakerGrid = document.querySelector('.sneaker-grid');
const modal = document.querySelector('.modal');
const closeModal = document.querySelector('.close-modal');
const addSneakerBtn = document.querySelector('.add-sneaker-btn');
const sneakerForm = document.querySelector('#sneaker-form');

// Animation on scroll
const animateOnScroll = () => {
    const elements = document.querySelectorAll('.card, .sneaker-card');
    elements.forEach(element => {
        const elementTop = element.getBoundingClientRect().top;
        const elementBottom = element.getBoundingClientRect().bottom;
        
        if (elementTop < window.innerHeight && elementBottom > 0) {
            element.style.opacity = '1';
            element.style.transform = 'translateY(0)';
        }
    });
};

// Search functionality
const handleSearch = (e) => {
    const searchTerm = e.target.value.toLowerCase();
    const sneakerCards = document.querySelectorAll('.sneaker-card');
    
    sneakerCards.forEach(card => {
        const title = card.querySelector('.sneaker-title').textContent.toLowerCase();
        const description = card.querySelector('.sneaker-description').textContent.toLowerCase();
        
        if (title.includes(searchTerm) || description.includes(searchTerm)) {
            card.style.display = 'block';
            card.style.animation = 'fadeIn 0.5s ease-out';
        } else {
            card.style.display = 'none';
        }
    });
};

// Modal functionality
const showModal = () => {
    modal.style.display = 'block';
    document.body.style.overflow = 'hidden';
};

const hideModal = () => {
    modal.style.display = 'none';
    document.body.style.overflow = 'auto';
};

// Form submission
const handleFormSubmit = async (e) => {
    e.preventDefault();
    
    const formData = new FormData(sneakerForm);
    const data = Object.fromEntries(formData);
    
    try {
        const response = await fetch('/api/sneakers', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        
        if (response.ok) {
            showAlert('Sneaker added successfully!', 'success');
            hideModal();
            loadSneakers();
        } else {
            throw new Error('Failed to add sneaker');
        }
    } catch (error) {
        showAlert('Error adding sneaker. Please try again.', 'error');
    }
};

// Alert messages
const showAlert = (message, type) => {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type}`;
    alertDiv.textContent = message;
    
    document.body.appendChild(alertDiv);
    
    setTimeout(() => {
        alertDiv.remove();
    }, 3000);
};

// Load sneakers
const loadSneakers = async () => {
    try {
        const response = await fetch('/api/sneakers');
        const sneakers = await response.json();
        
        sneakerGrid.innerHTML = '';
        
        sneakers.forEach(sneaker => {
            const card = createSneakerCard(sneaker);
            sneakerGrid.appendChild(card);
        });
    } catch (error) {
        showAlert('Error loading sneakers. Please try again.', 'error');
    }
};

// Create sneaker card
const createSneakerCard = (sneaker) => {
    const card = document.createElement('div');
    card.className = 'sneaker-card';
    
    card.innerHTML = `
        <img src="${sneaker.image_url}" alt="${sneaker.name}" class="sneaker-image">
        <div class="ethical-badge">${sneaker.ethical_certification}</div>
        <div class="sneaker-info">
            <h3 class="sneaker-title">${sneaker.name}</h3>
            <p class="sneaker-description">${sneaker.description}</p>
            <p class="sneaker-price">$${sneaker.price}</p>
            <button class="btn btn-primary add-to-cart">Add to Cart</button>
        </div>
    `;
    
    return card;
};

// Event Listeners
document.addEventListener('DOMContentLoaded', () => {
    loadSneakers();
    window.addEventListener('scroll', animateOnScroll);
});

searchInput.addEventListener('input', handleSearch);
addSneakerBtn.addEventListener('click', showModal);
closeModal.addEventListener('click', hideModal);
sneakerForm.addEventListener('submit', handleFormSubmit);

// Close modal when clicking outside
modal.addEventListener('click', (e) => {
    if (e.target === modal) {
        hideModal();
    }
});

// Smooth scroll for anchor links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        document.querySelector(this.getAttribute('href')).scrollIntoView({
            behavior: 'smooth'
        });
    });
});

// Add to cart functionality
document.addEventListener('click', (e) => {
    if (e.target.classList.contains('add-to-cart')) {
        const card = e.target.closest('.sneaker-card');
        const title = card.querySelector('.sneaker-title').textContent;
        const price = card.querySelector('.sneaker-price').textContent;
        
        // Add to cart logic here
        showAlert(`${title} added to cart!`, 'success');
    }
}); 