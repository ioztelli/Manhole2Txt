(defun c:pipe_info ()
  (vl-load-com)

  (setq top_name_obj (car (entsel "\nSelect text object for Top Manhole Name: ")))
  (setq top_invert_elevation_obj (car (entsel "\nSelect text object for Top Invert Elevation: ")))
  (setq bottom_name_obj (car (entsel "\nSelect text object for Bottom Manhole Name: ")))
  (setq bottom_invert_elevation_obj (car (entsel "\nSelect text object for Bottom Invert Elevation: ")))
  (setq diameter_obj (car (entsel "\nSelect text object for Diameter: ")))

  (if (and top_name_obj top_invert_elevation_obj bottom_name_obj bottom_invert_elevation_obj diameter_obj)
    (progn
      (setq top_name_data (vlax-ename->vla-object top_name_obj))
      (setq top_invert_elevation_data (vlax-ename->vla-object top_invert_elevation_obj))
      (setq bottom_name_data (vlax-ename->vla-object bottom_name_obj))
      (setq bottom_invert_elevation_data (vlax-ename->vla-object bottom_invert_elevation_obj))
      (setq diameter_data (vlax-ename->vla-object diameter_obj))

      (if (and
           (= (vla-get-objectname top_name_data) "AcDbText")
           (= (vla-get-objectname top_invert_elevation_data) "AcDbText")
           (= (vla-get-objectname bottom_name_data) "AcDbText")
           (= (vla-get-objectname bottom_invert_elevation_data) "AcDbText")
           (= (vla-get-objectname diameter_data) "AcDbText"))
        (progn
          (setq top_name (vla-get-textstring top_name_data))
          (setq top_invert_elevation (vla-get-textstring top_invert_elevation_data))
          (setq bottom_name (vla-get-textstring bottom_name_data))
          (setq bottom_invert_elevation (vla-get-textstring bottom_invert_elevation_data))
          (setq diameter (vla-get-textstring diameter_data))

          (setq filename "pipe.txt")
          (setq f (open filename "a"))
	  (write-line (strcat top_name ","bottom_name "," top_invert_elevation "," bottom_invert_elevation "," diameter ) f)


          (close f)
          (princ "\nData appended to 'pipe.txt' file.")
	  ;; Change the color of the selected line to blue
          (vla-put-color top_name_data 5)
	  (vla-put-color top_invert_elevation_data 5)
	  (vla-put-color bottom_invert_elevation_data 5)
        )
        (princ "\nError: Invalid object type(s).")
      )
    )
    (princ "\nError: Selection cancelled.")
  )
  (princ)
)
