library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM; 
use UNISIM.VComponents.all;
 
entity Memoria is
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
end Memoria;
architecture Behavioral of Memoria is
type REG is array (11 downto 0) of std_logic_vector (7 downto 0);
signal registro: REG; 
signal selector: integer range 0 to 11;
signal up_ant, dn_ant, rst_ant: std_logic;
begin  
    up_ant <= up when clk'event and clk='1'; 
    dn_ant <= dn when clk'event and clk='1';
    rst_ant <= rst when clk'event and clk='1';
    num1 <= std_logic_vector(to_unsigned(selector, num1'length)); 
   process (registro,selector)
    begin
        num2 <= registro(selector);
    end process; 
    
    process (ADDR, DATO,clk , OK)
    begin
        if rising_edge(clk) then
            if (ok='1') then 
                registro(to_integer(unsigned(ADDR))) <= DATO;
            elsif (rst='1' and rst_ant='0') then
              for i in 0 to 11 loop
                registro(i) <= "00000000";
              end loop; 
            end if;
        end if;
    end process;   

   process (clk, up, up_ant, dn_ant, dn)
    begin
        if rising_edge(clk) then
            if (up='1' and up_ant='0') then 
                if(selector=11) then 
                    selector <= 0;
                else 
                    selector <= selector+1;
                end if; 
            elsif (dn='1' and dn_ant='0') then 
                if(selector=0) then 
                    selector <= 11;
                else 
                    selector <= selector-1;
                end if; 
            else 
                selector <= selector;
            end if;     
        end if;
    end process;       
end Behavioral;

