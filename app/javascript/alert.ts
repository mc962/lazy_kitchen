const FLASH_CONTAINER_SELECTOR = '.flash-container';
const FLASH_CLOSE_CLASS = 'flash-close';
const HIDDEN_FLASH_CLASS = 'hidden-flash';

export const setupFlashAlerts = () => {
    const flashContainers: Array<Element> = Array.from(document.querySelectorAll(FLASH_CONTAINER_SELECTOR));

    flashContainers.forEach((containerEl) => {
        containerEl.addEventListener('click', (event: Event) => {
            const clickedEl = event.target as HTMLElement;
            if (clickedEl.classList.contains(FLASH_CLOSE_CLASS)) {
                closeFlash(containerEl as HTMLDivElement);
            }
        });
    });
}

const closeFlash = (containerEl: HTMLDivElement) => {
    // Describe elements as hidden (although CSS display changes may override its visibility)
    containerEl.setAttribute('hidden', 'true');

    // Add class to hide flash from display
    containerEl.classList.add(HIDDEN_FLASH_CLASS);
}