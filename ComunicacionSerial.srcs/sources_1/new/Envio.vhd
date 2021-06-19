library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Envio is
  Port ( Tx: out std_logic;--Senal externa: Realiza la transmision de datos 
         St: in std_logic; --Boton: Inicia la transmision de datos 
         clk: in std_logic --Reloj: Señal de reloj
        );
end Envio;
architecture Behavioral of Envio is
--Envio de datos
signal init: std_logic; 
signal nBit_tx: integer range 0 to 10;
signal cont_tx: integer range 0 to 10416; 
signal st_ant: std_logic; 
type registro is array (3 downto 0) of std_logic_vector (7 downto 0);
signal Reg_Tx: registro; 
signal nByte_tx: integer range 0 to 4;
begin
    st_ant <= st when clk'event and clk='1'; 
    Reg_Tx(0)   <=x"21";
    Reg_Tx(1)   <=x"52";
    Reg_Tx(2)   <=x"57";
    Reg_Tx(3)   <=x"0F";
    process (clk, st_ant, st, nByte_tx)
    begin
            if(nByte_tx=4) then 
                    init <= '0';
            elsif (st_ant='0' and st='1' and rising_edge(clk)) then 
                    init <= '1'; 
            end if;
    end process;
    
    process (clk, init, cont_tx, nBit_tx, nByte_Tx, Reg_Tx)
    begin 
    if rising_edge(clk) theN
        if (cont_tx=10416 or init='0') then 
            cont_tx <= 0;
        else 
             cont_tx <= cont_tx+1;
        end if;
   
        if (nBit_tx=10 or init='0') then 
            nBit_tx <= 0;
        elsif cont_tx=10415 then 
             nBit_tx <= nBit_tx+1;
        end if; 
        
        if (init='0') then 
            nByte_tx <= 0;
        elsif nBit_Tx=9 and cont_tx=10415 then 
             nByte_tx <= nByte_tx+1;
        end if;
        
        if (init='1' and nbit_tx=0) then 
            Tx <= '0';
        elsif(nbit_tx>0 and nbit_tx<9) then
             Tx <= Reg_Tx(nByte_tx)(nbit_tx-1); 
        else 
             Tx<='1';
        end if;
      end if; 
    end process;
end Behavioral;
