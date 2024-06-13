module fileIO
    use globalVars
    implicit none
    
    contains
    
    !read cube file (only for the case that only one orbital contained)
    !todo: generalize to multiple orbitals
    subroutine cuberead(filename, reslu, atoms_num, atom_list, origin, vecx, vecy, vecz, cubexyz)
        character(len=200), intent(in):: filename
        
        type(atom), allocatable, intent(out):: atom_list(:)
        
        integer, intent(out):: reslu(3), atoms_num
        
        real*8, intent(out):: origin(3), vecx(3), vecy(3), vecz(3)
        real*8, allocatable, intent(out):: cubexyz(:,:,:)
        
        integer:: i, j
        
        open(10, file=filename, status="old")
            read(10,*) !skip first line
            read(10,*) !skip second line
            
            read(10,"(i5, 3f12.6)") atoms_num, origin
            read(10,"(i5, 3f12.6)") reslu(1), vecx
            read(10,"(i5, 3f12.6)") reslu(2), vecy
            read(10,"(i5, 3f12.6)") reslu(3), vecz
            
            allocate(atom_list(atoms_num))
            allocate(cubexyz(reslu(1), reslu(2), reslu(3)))
            
            do i = 1, atoms_num
                read(10,"(i5, 4f12.6)") atom_list(i)%atom_index, atom_list(i)%charge, atom_list(i)%position
            end do
            
            do i = 1, reslu(1)
                do j = 1, reslu(2)
                    read(10, "(6(1PE14.5E3))") cubexyz(i,j,:)
                end do
            end do
            
        close(10)
    
    end subroutine cuberead
    
    !write cube file
    subroutine cubewrite(filename, reslu, atoms_num, atom_list, origin, vecx, vecy, vecz, cubexyz)
        character(len=200), intent(in):: filename
        
        type(atom), allocatable, intent(in):: atom_list(:)
        
        integer, intent(in):: reslu(3), atoms_num
        
        real*8, intent(in):: origin(3), vecx(3), vecy(3), vecz(3)
        real*8, intent(in):: cubexyz(:,:,:)   
        
        integer:: i, j
        
        open(11, file=filename, status="replace")
            write(11,*) "Golin's cube file"
            write(11,"(a,i20,a)") "Totally", reslu(1)*reslu(2)*reslu(3), "grids points"
            
            write(11,"(i5, 3f12.6)") atoms_num, origin
            write(11,"(i5, 3f12.6)") reslu(1), vecx
            write(11,"(i5, 3f12.6)") reslu(2), vecy
            write(11,"(i5, 3f12.6)") reslu(3), vecz
            
            do i = 1, atoms_num
                write(11,"(i5, 4f12.6)") atom_list(i)%atom_index, atom_list(i)%charge, atom_list(i)%position
            end do
            
            do i = 1, reslu(1)
                do j = 1, reslu(2)
                    write(11, "(6(1PE14.5E3))") cubexyz(i,j,:)
                end do
            end do
            
        close(11)
        
    end subroutine cubewrite

end module fileIO
