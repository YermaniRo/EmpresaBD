DELIMITER $$
CREATE FUNCTION verificar_stock(p_id INT, cantidad INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE stock_actual INT;
    SELECT stock INTO stock_actual FROM productos WHERE id_producto = p_id;
    RETURN stock_actual >= cantidad;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE realizar_pedido(IN cliente_id INT, IN producto_id INT, IN cantidad INT)
BEGIN
    IF verificar_stock(producto_id, cantidad) THEN
        INSERT INTO pedidos(id_cliente, id_producto, cantidad, fecha)
        VALUES (cliente_id, producto_id, cantidad, NOW());
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Stock insuficiente';
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER actualizar_stock
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock = stock - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END$$
DELIMITER ;

