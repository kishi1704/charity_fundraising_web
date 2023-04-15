package dao;

public interface BaseDAO<T> {
	T get(int id);
	boolean update(T obj);
	T insert(T obj);
	boolean delete(int id);
}
