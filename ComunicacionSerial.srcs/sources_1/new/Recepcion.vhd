library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity Recepcion is
  Port (Rx: in std_logic; --Senal externa: Realiza la recepción de datos 
        addr : out std_logic_vector (3 downto 0); --Senal interna: Direccion donde se guarda el dato
        dato : out std_logic_vector (7 downto 0); --Senal interna: Dato que se va a guardar
        ok: out std_logic; --Senal interna: Activa el guardado
        clk: in std_logic --Reloj: Señal de reloj
       );
end Recepcion;
architecture Behavioral of Recepcion is
signal init: std_logic; 
signal rx_ant: std_logic;
signal nBit_rx: integer range 0 to 10;
signal cont_rx: integer range 0 to 10416; 
signal nByte_rx: integer range 0 to 12;
signal acumulador: std_logic_vector (7 downto 0);
begin
    rx_ant <= rx when clk'event and clk='1'; 
    process (clk, rx_ant, rx, nByte_rx)
    begin
        if nByte_rx=12 then 
            init <= '0';
        elsif(rx_ant='1' and rx='0' and rising_edge(clk)) then 
            init <= '1';
        end if;
    end process;
    
    
    process (clk, rx, cont_rx, init)
    
    begin
        if rising_edge(clk) then
            if (cont_rx=10416 or init='0') then 
                cont_rx <= 0;
            else 
                cont_rx <= cont_rx+1;
            end if;
   
            if (nBit_rx=10 or init='0') then 
                nBit_rx <= 0;
                acumulador <= "00000000";
            elsif cont_rx=10415 then 
                nBit_rx <= nBit_rx+1;
            end if; 
        
            if (init='0') then 
                nByte_rx <= 0;
            elsif nBit_rx=9 and cont_rx=10415 then 
                nByte_rx <= nByte_rx+1;
            end if;
            
            if(init='1' and nbit_rx>0 and nbit_rx<9 and cont_rx=4000) then
                acumulador(nbit_rx-1) <=Rx; 
            end if;
            
            if (init='1' and nBit_rx=8 and cont_rx=5000) then 
                addr<= std_logic_vector(to_unsigned(nByte_rx, addr'length)); 
                dato<= acumulador;
            end if; 
            if(init='1' and nBit_rx=8 and cont_rx=8000) then 
                ok<= '1';
            else     
                ok<= '0';
            end if;           
        end if;
    end process; 
end Behavioral;
