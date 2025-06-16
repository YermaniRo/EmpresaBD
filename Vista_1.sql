CREATE VIEW vista_pedidos AS
SELECT 
    p.id_pedido,
    c.nombre AS cliente,
    pr.nombre AS producto,
    p.cantidad,
    p.fecha
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN productos pr ON p.id_producto = pr.id_producto;

CREATE VIEW vista_productos_stock AS
SELECT nombre, stock
FROM productos
WHERE stock > 0;

CREATE VIEW vista_clientes_frecuentes AS
SELECT c.nombre, COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente
HAVING total_pedidos > 1;

CREATE VIEW vista_productos_mas_vendidos AS
SELECT pr.nombre, SUM(p.cantidad) AS total_vendido
FROM productos pr
JOIN pedidos p ON pr.id_producto = p.id_producto
GROUP BY pr.id_producto
ORDER BY total_vendido DESC;

