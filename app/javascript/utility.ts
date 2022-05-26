export const debounce = (func: Function, timeout, immediate) => {
    let timeoutId: ReturnType<typeof setTimeout>;
    return function (this: any, ...args: any[]) {
        const later = function () {
            timeout = null;
            if (!immediate) {
                func.apply(this, ...args)
            }
        }
        const callNow = immediate && !timeout;
        clearTimeout(timeoutId);
        timeoutId = setTimeout(later, timeout);

        if (callNow) {
            func.apply(this, ...args);
        }
    };
};