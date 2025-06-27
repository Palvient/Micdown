/**
 * Formats a timestamp into a readable date and time string.
 * @param timestamp - The timestamp to format.
 * @returns A formatted date string.
 */
export const formatTimestamp = (timestamp: number): string => {
  const date = new Date(timestamp);
  return date.toLocaleString();
};

/**
 * Generates a unique identifier (UUID).
 * @returns A UUID string.
 */
export const generateUUID = (): string => {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, (c) => {
    const r = (Math.random() * 16) | 0;
    const v = c === 'x' ? r : (r & 0x3) | 0x8;
    return v.toString(16);
  });
};

/**
 * Validates if a string is a valid email address.
 * @param email - The email string to validate.
 * @returns True if valid, false otherwise.
 */
export const isValidEmail = (email: string): boolean => {
  const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return regex.test(email);
};