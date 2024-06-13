module globalVars
    
    type:: atom
        integer:: atom_index
        real*8:: charge
        real*8:: position(3)
    end type atom
    
    contains
        subroutine readinput(filename)
            character(len=200), intent(out):: filename
        
            open(10, file='input.txt', status='old')
                read(10,"(a)") filename
            close(10)
        end subroutine readinput
    
end module globalVars