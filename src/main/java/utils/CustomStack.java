package utils;

import java.util.EmptyStackException;

public class CustomStack<T> implements Stack<T> {
    private Object[] stackArray;
    private int top;
    private static final int DEFAULT_CAPACITY = 10;

    public CustomStack() {
        this.stackArray = new Object[DEFAULT_CAPACITY];
        this.top = -1;
    }

    public void push(T item) {
        if (top == stackArray.length - 1) {
            resize();
        }
        stackArray[++top] = item;
    }

    @SuppressWarnings("unchecked")
    public T pop() {
        if (isEmpty()) throw new EmptyStackException();
        T item = (T) stackArray[top];
        stackArray[top--] = null; // Help GC
        return item;
    }

    @SuppressWarnings("unchecked")
    public T peek() {
        if (isEmpty()) throw new EmptyStackException();
        return (T) stackArray[top];
    }

    public boolean isEmpty() {
        return top == -1;
    }

    public int size() {
        return top + 1;
    }

    private void resize() {
        Object[] newArray = new Object[stackArray.length * 2];
        System.arraycopy(stackArray, 0, newArray, 0, stackArray.length);
        stackArray = newArray;
    }//Doubles the size of the array when it gets ful

    // Changed to return Object[] instead of T[]
    public Object[] getRemainingItems() {
        Object[] items = new Object[top + 1];
        System.arraycopy(stackArray, 0, items, 0, top + 1);
        return items;
    }
}
