(defun c:manhole_info ()
  (vl-load-com)

  (setq clicked_point (getpoint "\nClick a point: "))
  (setq name_obj (car (entsel "\nSelect text object for Name: ")))
  (setq top_elevation_obj (car (entsel "\nSelect text object for Top Elevation: ")))
  (setq invert_elevation_obj (car (entsel "\nSelect text object for Invert Elevation: ")))

  (if (and clicked_point name_obj top_elevation_obj invert_elevation_obj)
    (progn
      (setq name_data (vlax-ename->vla-object name_obj))
      (setq top_elevation_data (vlax-ename->vla-object top_elevation_obj))
      (setq invert_elevation_data (vlax-ename->vla-object invert_elevation_obj))

      (if (and
           (= (vla-get-objectname name_data) "AcDbText")
           (= (vla-get-objectname top_elevation_data) "AcDbText")
           (= (vla-get-objectname invert_elevation_data) "AcDbText"))
        (progn
          (setq name (vla-get-textstring name_data))
          (setq top_elevation (vla-get-textstring top_elevation_data))
          (setq invert_elevation (vla-get-textstring invert_elevation_data))

          (setq formatted_x (rtos (car clicked_point) 2 3))
          (setq formatted_y (rtos (cadr clicked_point) 2 3))

          (setq filename "manhole.txt")
          (setq f (open filename "a"))
	  (write-line (strcat name ","  formatted_x ", " formatted_y "," top_elevation "," invert_elevation ) f)
          (close f)
          (princ "\nData appended to 'manhole.txt' file.")
	  (entmake (list
                     '(0 . "CIRCLE")
                     (cons 10 clicked_point)
                     (cons 40 1.0) ; Radius = Diameter / 2
                     '(62 . 5) ; Color index 5 = blue
                   ))
        )
        (princ "\nError: Invalid object type(s).")
      )
    )
    (princ "\nError: Selection cancelled.")
  )
  (princ)
)
