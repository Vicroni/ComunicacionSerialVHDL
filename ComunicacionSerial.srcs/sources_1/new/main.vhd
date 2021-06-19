library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity main is
    Port ( 
    clk_m: in std_logic; --Reloj: Señal de reloj 
    dn_m: in std_logic; --Boton: Decrementa el uno la direccion de memoria que se despliega
    up_m: in std_logic; --Boton: Incrementa el uno la direccion de memoria que se despliega
    rst_m: in std_logic; --Boton: Limpia los valores en memoria
    seg_m: out std_logic_vector (6 downto 0); --Display: Despliega el numero del display 
    an_m: out std_logic_vector (7 downto 0);  --Display: Controla el anodo del numero del display 
    Rx_m: in std_logic; --Senal externa: Realiza la recepción de datos 
    Tx_m: out std_logic;--Senal externa: Realiza la transmision de datos 
    St_m: in std_logic; --Boton: Inicia la transmision de datos 

    UART_CTS: out std_logic; --Flujo auxiliar
    UART_RTS: in std_logic --Flujo auxiliar
    );
end main;
architecture Behavioral of main is
component Memoria is
    Port (    
    num1: out std_logic_vector (7 downto 0); --Senal interna: Numero 1 en el display
    num2: out std_logic_vector (7 downto 0); --Senal interna: Numero 2 en el display 
    addr : in std_logic_vector (3 downto 0); --Senal interna: Direccion donde se guarda el dato
    dato : in std_logic_vector (7 downto 0); --Senal interna: Dato que se va a guardar
    ok: in std_logic; --Senal interna: Activa el guardado
    dn: in std_logic; --Boton: Decrementa el uno la direccion de memoria que se despliega
    up: in std_logic; --Boton: Incrementa el uno la direccion de memoria que se despliega
    clk: in std_logic; --Reloj: Señal de reloj 
    rst: in std_logic --Boton: Limpia los valores en memoria
    );
end component;  
component Display is
    Port ( 
    num1: in std_logic_vector (7 downto 0); --Senal interna: Numero 1 en el display 
    num2: in std_logic_vector (7 downto 0); --Senal interna: Numero 2 en el display 
    seg: out std_logic_vector (6 downto 0); --Display: Despliega el numero del display 
    an: out std_logic_vector (7 downto 0);  --Display: Controla el anodo del numero del display 
    clk: in std_logic  --Reloj: Señal de reloj 
    );
end component;  
component Recepcion is
  Port (Rx: in std_logic; --Senal externa: Realiza la recepción de datos 
        addr : out std_logic_vector (3 downto 0); --Senal interna: Direccion donde se guarda el dato
        dato : out std_logic_vector (7 downto 0); --Senal interna: Dato que se va a guardar
        ok: out std_logic; --Senal interna: Activa el guardado
        clk: in std_logic --Reloj: Señal de reloj

       );
end component;    
component Envio is
  Port ( Tx: out std_logic;--Senal externa: Realiza la transmision de datos 
         St: in std_logic; --Boton: Inicia la transmision de datos 
         clk: in std_logic --Reloj: Señal de reloj
        );
end component;    
signal num1_m:  std_logic_vector (7 downto 0); 
signal num2_m:  std_logic_vector (7 downto 0); 
signal addr_m :  std_logic_vector (3 downto 0); 
signal dato_m :  std_logic_vector (7 downto 0); 
signal ok_m:  std_logic; 
begin
  memoria_comp: Memoria port map (
    num1=>num1_m, 
    num2=>num2_m, 
    addr=>addr_m, 
    dato=>dato_m, 
    ok=>ok_m, 
    dn=> dn_m,
    up=>up_m,
    clk=>clk_m,
    rst=>rst_m
  );
  display_comp: Display port map (
    num1=> num1_m,
    num2=> num2_m,
    seg=>seg_m, 
    an=>an_m,  
    clk=>clk_m
  );
 recepcion_comp: Recepcion port map (
    Rx=> Rx_m,
    addr=>addr_m,
    dato=>dato_m, 
    ok=>ok_m, 
    clk=>clk_m
  );
  envio_comp: Envio port map (
    Tx=> Tx_m,
    St=>st_m,
    clk=>clk_m
  );

  UART_CTS <='0';
end Behavioral;



