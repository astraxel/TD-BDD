Q13 :
CREATE FUNCTION add_jstudent() RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
	BEGIN
		IF NEW.first LIKE 'J%' THEN
			INSERT INTO studentjm VALUES (NEW.id, NEW.first, NEW.last);
		END IF;
		RETURN NEW;
	END;
$$;

CREATE TRIGGER add_students AFTER INSERT ON student FOR EACH ROW EXECUTE PROCEDURE add_jstudent();

CREATE FUNCTION del_jstudent() RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
	BEGIN
		IF OLD.first LIKE 'J%' THEN
			DELETE FROM studentjm WHERE id = OLD.id;
		END IF;
		RETURN NEW;
	END;
$$;

CREATE TRIGGER del_students AFTER DELETE ON student FOR EACH ROW EXECUTE PROCEDURE del_jstudent();

CREATE FUNCTION upd_jstudent() RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
	BEGIN
		IF OLD.first LIKE 'J%' THEN
			DELETE FROM studentjm WHERE id=OLD.id;
		END IF;
		IF NEW.first LIKE 'J%' THEN
			INSERT INTO studentjm VALUES (NEW.id, NEW.first, NEW.last);
		END IF;
		RETURN NEW;
	END;
$$;

CREATE TRIGGER upd_students AFTER UPDATE ON student FOR EACH ROW EXECUTE PROCEDURE upd_jstudent();


Q15 :

CREATE FUNCTION upd_avg() RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
	BEGIN
		IF OLD.student != NEW.student THEN
			RAISE 'Cannot change student id';
		END IF;
		IF OLD.grade != NEW.grade THEN
			RAISE 'Cannot change student average grade';
		END IF;
		UPDATE student SET first = NEW.first, last = NEW.last WHERE id = NEW.student;
		RETURN NEW;
	END;
$$;

CREATE TRIGGER upd_std_avg INSTEAD OF UPDATE ON averagev FOR EACH ROW EXECUTE PROCEDURE upd_avg();

CREATE FUNCTION del_avg() RETURNS TRIGGER
	LANGUAGE plpgsql
AS $$
	BEGIN
		DELETE FROM student WHERE id=OLD.student;
		RETURN NEW;
	END;
$$;

CREATE TRIGGER del_std_avg INSTEAD OF DELETE ON averagev FOR EACH ROW EXECUTE PROCEDURE del_avg();

