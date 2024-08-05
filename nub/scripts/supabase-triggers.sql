-- Function to handle new user creation
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER
SECURITY DEFINER SET search_path = public
LANGUAGE plpgsql
AS $$
DECLARE
    user_role UserRole;
BEGIN
    -- Determine the user role
    user_role := CASE UPPER(NEW.raw_user_meta_data->>'role')
        WHEN 'CUSTOMER' THEN 'CUSTOMER'::UserRole
        WHEN 'DELIVERY_PERSON' THEN 'DELIVERY_PERSON'::UserRole
        WHEN 'ADMIN' THEN 'ADMIN'::UserRole
        WHEN 'RESTAURANT' THEN 'RESTAURANT'::UserRole
        ELSE 'CUSTOMER'::UserRole
    END;

    IF user_role = 'RESTAURANT' THEN 
        -- Insert into public.users
    INSERT INTO public.restaurants (id, email, "phoneNumber" ,name)
    VALUES (
        NEW.id,
        NEW.email,
        NEW.phone,
        COALESCE(NEW.raw_user_meta_data->>'name', 'nobody')
    );
    ELSE
    -- Insert into public.users
    INSERT INTO public.users (id, email, "phoneNumber", name, role)
    VALUES (
        NEW.id,
        NEW.email,
        NEW.phone,
        COALESCE(NEW.raw_user_meta_data->>'name', 'nobody'),
        user_role
    );
    END IF;


    RETURN NEW;
END;
$$;

-- Trigger the function every time a user is created
CREATE OR REPLACE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();