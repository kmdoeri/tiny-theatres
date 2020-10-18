import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class App {
    public static void main(String[] args) {

        ArrayList<Reservation> result = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader("./excel_data.csv"))) {

            reader.readLine();

            for (String line = reader.readLine(); line != null; line = reader.readLine()) {

                String[] fields = line.split(",", -1);
                if (fields.length == 15) {
                    result.add(deserialize(fields));
                }
            }
        } catch (IOException ex) {

        }
        writeAll(result);

    }

private static Reservation deserialize(String[] fields) {
       Reservation result = new Reservation();
       result.setCustomer_first(fields[0]);
       result.setCustomer_last(fields[1]);
       result.setCustomer_email(fields[2]);
       result.setCustomer_phone(fields[3]);
       result.setCustomer_address(fields[4]);
       result.setSeat(fields[5]);
       result.setShow(fields[6]);
       result.setTicket_price(fields[7]);
       result.setDate(fields[8]);
       result.setTheater(fields[9]);
       result.setTheater_address(fields[10] + "," + fields[11] + "," + fields[12]);
       result.setTheater_phone(fields[13]);
       result.setTheater_email(fields[14]);
       return result;
}

private static String serialize(Reservation reservation) {
        return String.format("insert into excel_data (customer_first, customer_last, customer_email, customer_phone," +
                "customer_address, seat, `show`, ticket_price, `date`, theater, theater_address, theater_phone, theater_email) " +
                "\nvalues (\"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", \"%s\", '%s', \"%s\", \"%s\");\n",
                reservation.getCustomer_first(), reservation.getCustomer_last(), reservation.getCustomer_email(),
                reservation.getCustomer_phone(), reservation.getCustomer_address(), reservation.getSeat(),
                reservation.getShow(), reservation.getTicket_price(), reservation.getDate(), reservation.getTheater(),
                reservation.getTheater_address(), reservation.getTheater_phone(), reservation.getTheater_email());
}

private static void writeAll(List<Reservation> reservations) {
        try (PrintWriter writer = new PrintWriter(("./excel_data.sql"))) {
            writer.println("use tiny_theatres;");


            for (Reservation reservation : reservations) {
                writer.println(serialize(reservation));
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

}
}
