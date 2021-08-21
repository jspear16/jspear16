module Accelerations
    integer, parameter:: sizex = 16, sizey = 16, n = 1, &
    m = 1, numperiods = 10, numsteps = 1000 * numperiods
    double precision, parameter:: PI = 4.0 *atan(1.d0), TotalTime = 0.5

    contains
!--------------------------------------------------------------------------------------------------------------------
    subroutine pop_al(al, cx, cy)
        implicit none
        integer:: i, j, nRow
        double precision, dimension(:,:):: cx, cy
        double precision, dimension(:,:):: al

        do i = 1, sizex
            do j = 1, sizey
                nRow = (j-1) * sizex + i
                al(nRow,nRow) = -2.0*(cx(i,j) + cy(i,j))

                if (i .ne. 1) then
                    al(nRow, nRow - 1) = cx(i,j)
                end if

                if (i .ne. sizex) then
                    al(nRow, nRow + 1) = cx(i,j)
                end if

                if (j .ne. 1) then
                    al(nRow, nRow - sizex) = cy(i,j)
                end if

                if (j .ne. sizey) then
                    al(nRow, nRow + sizex) = cy(i,j)
                end if

            end do
        end do
    end subroutine pop_al
!--------------------------------------------------------------------------------------------------------------------
    subroutine pop_au(u, al, a)
        implicit none
        integer:: n1, m1
        double precision, dimension(:,:):: al
        double precision, dimension(:):: u, a

        a(:) = 0.0

        do n1 = 1, sizex*sizey
            do m1 = 1, sizex*sizey
                a(n1) = al(n1, m1) * u(m1) + a(n1)
            end do
        end do

    end subroutine pop_au
!--------------------------------------------------------------------------------------------------------------------
    subroutine calc_RK4(u, v, al, tau)
        implicit none
        double precision, dimension(:,:):: u, v
        double precision, dimension(sizex*sizey,sizex*sizey):: al
        double precision, dimension(1:sizex*sizey):: KU1, KU2, KU3, KU4, &
        KV1, KV2, KV3, KV4
        integer:: i
        double precision:: tau


        do i = 1, numsteps-1
            
            call pop_au(u(:,i), al, kv1)

            KU1 = v(:,i) ! K1 <---------------------------
            u(:, i+1) = u(:, i) + KU1*tau / 2.0
            KU2 = v(:, i) + KV1*tau / 2.0 ! K2 <---------------------------

            call pop_au(u(:, i+1), al, KV2)

            KU3 = v(:, i) + KV2*tau / 2.0 ! K3 <---------------------------
            u(:, i+1) = u(:, i) + KU2*tau / 2.0

            call pop_au(u(:, i+1), al, KV3)

            KU4 = v(:, i) + KV3*tau ! K4 <---------------------------
            u(:, i+1) = u(:, i) + KU3*tau

            call pop_au(u(:, i+1), al, KV4)

            u(:, i+1) = u(:, i) + (tau/6.0) * (KU1 + 2.0*KU2 + 2.0*KU3 + KU4)
            v(:, i+1) = v(:, i) + (tau/6.0) * (KV1 + 2.0*KV2 + 2.0*KV3 + KV4)
            write(*,*) i

        end do

    end subroutine calc_RK4

end module