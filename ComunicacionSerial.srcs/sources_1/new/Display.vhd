library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity Display is
    Port ( 
    num1: in std_logic_vector (7 downto 0); --Senal interna: Numero 1 en el display 
    num2: in std_logic_vector (7 downto 0); --Senal interna: Numero 2 en el display 
    seg: out std_logic_vector (6 downto 0); --Display: Despliega el numero del display 
    an: out std_logic_vector (7 downto 0);  --Display: Controla el anodo del numero del display 
    clk: in std_logic  --Reloj: Señal de reloj 
    );
end Display;
architecture Behavioral of Display is
signal numero2B, numero2A, numero1: integer range 0 to 15; 
signal contador: integer range 0 to 4000;
signal CA, CB, CC, CD: std_logic_vector (6 downto 0);
begin
    numero2B<= to_integer(unsigned(num2(3 downto 0)));
    numero2A<= to_integer(unsigned(num2(7 downto 4)));
    numero1<= to_integer(unsigned(num1));
      
   contador <= 0 when contador = 4000 else  
                contador+1 when  clk'event and clk='1';  
                                
    SEG  <= CA when contador>=0   and contador <1000 else 
            CB when contador>=1000 and contador <2000 else
            CC when contador>=2000 and contador <3000 else
            CD when contador>=3000 and contador <4000 else
            "1111111";   
                   
    AN   <= "01111111" when contador>=200   and contador <  800 else 
            "10111111" when contador>=1200 and contador < 1800 else
            "11011111" when contador>=2200 and contador < 2800 else
            "11101111" when contador>=3200 and contador < 3800 else
            "11111111";                  
    
    --Conversiona 7 segmentos        
    process (numero2A, numero2B, numero1)
    begin
        case numero2B is 
         when 0 => CD <= "0000001"; 
         when 1 => CD <= "1001111";
         when 2 => CD <= "0010010";
         when 3 => CD <= "0000110";
         when 4 => CD <= "1001100";
         when 5 => CD <= "0100100";
         when 6 => CD <= "0100000";
         when 7 => CD <= "0001111";
         when 8 => CD <= "0000000";
         when 9 => CD <= "0000100";
         when 10 => CD <= "0001000"; 
         when 11 => CD <= "1100000";
         when 12 => CD <= "0110001";
         when 13 => CD <= "1000010";
         when 14 => CD <= "0110000";
         when 15 => CD <= "0111000";
        end case; 
     
        case numero2A is 
         when 0 => CC <= "0000001"; 
         when 1 => CC <= "1001111";
         when 2 => CC <= "0010010";
         when 3 => CC <= "0000110";
         when 4 => CC <= "1001100";
         when 5 => CC <= "0100100";
         when 6 => CC <= "0100000";
         when 7 => CC <= "0001111";
         when 8 => CC <= "0000000";
         when 9 => CC <= "0000100";
         when 10 => CC <= "0001000"; 
         when 11 => CC <= "1100000";
         when 12 => CC <= "0110001";
         when 13 => CC <= "1000010";
         when 14 => CC <= "0110000";
         when 15 => CC <= "0111000";
        end case; 
         
        case numero1 is 
         when 0 => CB <= "0000001"; 
         when 1 => CB <= "1001111";
         when 2 => CB <= "0010010";
         when 3 => CB <= "0000110";
         when 4 => CB <= "1001100";
         when 5 => CB <= "0100100";
         when 6 => CB <= "0100000";
         when 7 => CB <= "0001111";
         when 8 => CB <= "0000000";
         when 9 => CB <= "0000100";
         when 10 => CB <= "0000001"; 
         when 11 => CB <= "1001111";
         when 12 => CB <= "0010010";
         when 13 => CB <= "0000110";
         when 14 => CB <= "1001100";
         when 15 => CB <= "0100100";
        end case; 
        
        if numero1 >=10 then  
            CA<= "1001111";
        else 
            CA <= "0000001";
        end if;   
    end process;
end Behavioral;